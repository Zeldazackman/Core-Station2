/obj/structure/trash_pile
	name = "trash pile"
	desc = "A heap of garbage, but maybe there's something interesting inside?"
	icon = 'icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	density = TRUE
	anchored = TRUE

	var/list/searchedby	= list()// Characters that have searched this trashpile, with values of searched time.
	var/mob/living/hider		// A simple animal that might be hiding in the pile

	var/obj/structure/mob_spawner/mouse_nest/mouse_nest = null

	var/chance_alpha	= 40	// Alpha list is junk items and normal random stuff.
	var/chance_beta		= 40	// Beta list is actually maybe some useful illegal items. If it's not alpha or gamma, it's beta.
	var/chance_gamma	= 20		// Gamma list is unique items only, and will only spawn one of each. This is a sub-chance of beta chance.

	//These are types that can only spawn once, and then will be removed from this list.
	//Alpha and beta lists are in their respective procs.
	var/global/list/unique_gamma = list(
		/obj/item/clothing/glasses/thermal/syndi,
		/obj/item/gun/projectile/pirate, //CHOMP Add
		/obj/item/gun/energy/mouseray/metamorphosis
		)

	var/global/list/allocated_gamma = list()

/obj/structure/trash_pile/Initialize(mapload)
	. = ..()
	icon_state = pick(
		"pile1",
		"pile2",
		"pilechair",
		"piletable",
		"pilevending",
		"brtrashpile",
		"microwavepile",
		"rackpile",
		"boxfort",
		"trashbag",
		"brokecomp")
	mouse_nest = new(src)

/obj/structure/trash_pile/Destroy()
	qdel(mouse_nest)
	mouse_nest = null
	return ..()

/obj/structure/trash_pile/attackby(obj/item/W as obj, mob/user as mob)
	var/w_type = W.type
	if(w_type in allocated_gamma)
		to_chat(user,span_notice("You feel \the [W] slip from your hand, and disappear into the trash pile."))
		user.unEquip(W)
		W.forceMove(src)
		allocated_gamma -= w_type
		unique_gamma += w_type
		qdel(W)

	else
		return ..()

/obj/structure/trash_pile/attack_generic(mob/user)
	//Simple Animal
	if(isanimal(user))
		var/mob/living/L = user
		//They're in it, and want to get out.
		if(L.loc == src)
			var/choice = tgui_alert(user, "Do you want to exit \the [src]?","Un-Hide?",list("Exit","Stay"))
			if(choice == "Exit")
				if(L == hider)
					hider = null
				L.forceMove(get_turf(src))
		else if(!hider)
			var/choice = tgui_alert(user, "Do you want to hide in \the [src]?","Un-Hide?",list("Hide","Stay"))
			if(choice == "Hide" && !hider) //Check again because PROMPT
				L.forceMove(src)
				hider = L
	else
		return ..()

/obj/structure/trash_pile/attack_ghost(mob/observer/user as mob)
	if(CONFIG_GET(flag/disable_player_mice))
		to_chat(user, span_warning("Spawning as a mouse is currently disabled."))
		return

	//VOREStation Add Start
	if(jobban_isbanned(user, JOB_GHOSTROLES))
		to_chat(user, span_warning("You cannot become a mouse because you are banned from playing ghost roles."))
		return
	//VOREStation Add End

	if(!user.MayRespawn(1))
		return

	var/turf/T = get_turf(src)
	if(!T || (T.z in using_map.admin_levels))
		to_chat(user, span_warning("You may not spawn as a mouse on this Z-level."))
		return

	var/timedifference = world.time - user.client.time_died_as_mouse
	if(user.client.time_died_as_mouse && timedifference <= mouse_respawn_time * 600)
		var/timedifference_text
		timedifference_text = time2text(mouse_respawn_time * 600 - timedifference,"mm:ss")
		to_chat(user, span_warning("You may only spawn again as a mouse more than [mouse_respawn_time] minutes after your death. You have [timedifference_text] left."))
		return

	var/response = tgui_alert(user, "Are you -sure- you want to become a mouse?","Are you sure you want to squeek?",list("Squeek!","Nope!"))
	if(response != "Squeek!") return  //Hit the wrong key...again.

	var/mob/living/simple_mob/animal/passive/mouse/host
	host = new /mob/living/simple_mob/animal/passive/mouse(get_turf(src))

	if(host)
		if(CONFIG_GET(flag/uneducated_mice))
			host.universal_understand = 0
		announce_ghost_joinleave(src, 0, "They are now a mouse.")
		host.ckey = user.ckey
		to_chat(host, span_info("You are now a mouse. Try to avoid interaction with players, and do not give hints away that you are more than a simple rodent."))

	var/atom/A = get_holder_at_turf_level(src)
	A.visible_message("[host] crawls out of \the [src].")
	return

/obj/structure/trash_pile/attack_hand(mob/user)
	//Human mob
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.visible_message("[user] searches through \the [src].",span_notice("You search through \the [src]."))
		if(hider)
			to_chat(hider,span_warning("[user] is searching the trash pile you're in!"))

		//Do the searching
		if(do_after(user,rand(4 SECONDS,6 SECONDS),src))

			//If there was a hider, chance to reveal them
			if(hider && prob(50))
				to_chat(hider,span_danger("You've been discovered!"))
				hider.forceMove(get_turf(src))
				hider = null
				to_chat(user,span_danger("Some sort of creature leaps out of \the [src]!"))

			//You already searched this one bruh
			else if(user.ckey in searchedby)
				to_chat(H,span_warning("There's nothing else for you in \the [src]!"))

			//You found an item!
			else
				var/luck = rand(1,100)
				var/obj/item/I
				if(luck <= chance_alpha)
					I = produce_alpha_item()
				else if(luck <= chance_alpha+chance_beta)
					I = produce_beta_item()
				else if(luck <= chance_alpha+chance_beta+chance_gamma)
					I = produce_gamma_item()

				//VOREstation edit - Randomized map objects were put in loot piles, so handle them...
				if(istype(I,/obj/random))
					var/obj/random/randy = I
					var/new_I = randy.spawn_item()
					qdel(I)
					I = new_I // swap it
				//VOREstation edit end

				//We either have an item to hand over or we don't, at this point!
				if(I)
					searchedby += user.ckey
					I.forceMove(get_turf(src))
					to_chat(H,span_notice("You found \a [I]!"))
					//CHOMPedit begin
					var/disturbed_sleep = rand(1,100) //spawning of mobs, for now only the trash panda.
					if(disturbed_sleep <= 5)
						new /mob/living/simple_mob/animal/passive/raccoon_ch(get_turf(user), name)
						visible_message("A raccoon jumps out of the trash!.")
					//CHOMPedit end

	else
		return ..()

//Random lists
/obj/structure/trash_pile/proc/produce_alpha_item()
	var/path = pick(prob(1);/obj/item/clothing/gloves/rainbow,
					prob(2);/obj/item/bluespace_harpoon,
					prob(2);/obj/item/reagent_containers/food/snacks/liquidfood,
					prob(3);/obj/item/spacecash/c1000,
					prob(1);/obj/item/storage/backpack/satchel,
					prob(1);/obj/item/storage/briefcase,
					prob(1);/obj/item/clothing/accessory/storage/webbing,
					prob(1);/obj/item/clothing/glasses/meson,
					prob(1);/obj/item/clothing/mask/gas,
					prob(1);/obj/item/clothing/suit/storage/toggle/bomber,
					prob(1);/obj/item/clothing/suit/storage/toggle/leather_jacket,
					prob(1);/obj/item/storage/box/donkpockets,
					prob(1);/obj/item/storage/box/mousetraps,
					prob(1);/obj/item/clothing/glasses/meson/prescription,
					prob(1);/obj/item/clothing/gloves/yellow,
					prob(1);/obj/item/clothing/gloves/sterile/latex,
					prob(1);/obj/item/clothing/head/welding,
					prob(1);/obj/item/clothing/under/syndicate/tacticool,
					prob(2);/obj/item/clothing/under/hyperfiber,
					prob(1);/obj/item/camera,
					prob(1);/obj/item/cell/super,
					prob(1);/obj/item/poster,
					prob(2);/obj/item/storage/box/sinpockets,
					prob(1);/obj/item/storage/secure/briefcase,
					prob(1);/obj/item/clothing/mask/gas/clear, //Chompadd: Proper implementation of clear gas masks
					prob(1);/obj/item/clothing/under/fluff/latexmaid,
					prob(2);/obj/item/bikehorn/rubberducky/blue,
					prob(2);/obj/item/bikehorn/rubberducky/pink,
					prob(1);/obj/item/bikehorn/rubberducky/grey,
					prob(1);/obj/item/bikehorn/rubberducky,
					prob(1);/obj/item/grenade/anti_photon/rubberducky/black,
					prob(1);/obj/item/bikehorn/rubberducky/white,
					prob(1);/obj/item/clothing/glasses/sunglasses,
					prob(1);/obj/item/clothing/glasses/welding,
					prob(1);/obj/item/clothing/head/ushanka,
					prob(2);/obj/item/seeds/lustflower,
					prob(2);/obj/item/clothing/shoes/syndigaloshes,
					prob(2);/obj/item/clothing/under/tactical,
					prob(2);/obj/item/paicard,
					prob(3);/obj/item/card/emag,
					prob(2);/obj/item/clothing/mask/gas/voice,
					prob(1);/obj/item/spacecash/c100,
					prob(3);/obj/item/storage/backpack/dufflebag/syndie,
					prob(3);/obj/item/pizzavoucher,
					prob(3);/obj/item/perfect_tele,
					prob(1);/obj/item/clothing/glasses/thermal/syndi,
					prob(2);/obj/item/gun/energy/netgun,
					prob(1);/obj/item/capture_crystal/basic,
					prob(2);/obj/item/capture_crystal/great,
					prob(2);/obj/item/capture_crystal/ultra,
					prob(2);/obj/item/capture_crystal/master,
					prob(1);/obj/item/capture_crystal/random,
					prob(1);/obj/item/storage/box/brainzsnax,
					prob(1);/obj/item/storage/box/brainzsnax/red,
					prob(1);/obj/item/clothing/glasses/sunglasses,
					prob(1);/obj/item/clothing/glasses/sunglasses/bigshot,
					prob(1);/obj/item/clothing/accessory/permit/gun,
					prob(1);/obj/item/clothing/mask/gas/voice,
					prob(1);/obj/item/spacecash/c50,
					prob(1);/obj/item/grenade/spawnergrenade/clustaur)// CHOMPStation edit

	var/obj/item/I = new path()
	return I

/obj/structure/trash_pile/proc/produce_beta_item()
	var/path = pick(prob(6);/obj/item/storage/pill_bottle/paracetamol,
					prob(4);/obj/item/storage/pill_bottle/happy,
					prob(4);/obj/item/storage/pill_bottle/zoom,
					prob(1);/obj/item/seeds/ambrosiavulgarisseed,
					prob(4);/obj/item/gun/energy/sizegun,
					prob(4);/obj/item/slow_sizegun,
					prob(2);/obj/item/clothing/accessory/collar/shock/bluespace,
					prob(3);/obj/item/cracker,
					prob(1);/obj/item/material/butterfly,
					prob(1);/obj/item/material/butterfly/switchblade,
					prob(1);/obj/item/clothing/gloves/heavy_engineer,
					prob(3);/obj/item/reagent_containers/syringe/drugs,
					prob(2);/obj/item/implanter/sizecontrol,
					prob(1);/obj/item/handcuffs/fuzzy,
					prob(1);/obj/item/handcuffs/legcuffs/fuzzy,
					prob(1);/obj/item/storage/box/syndie_kit/spy,
					prob(2);/obj/item/grenade/anti_photon,
					prob(2);/obj/item/clothing/under/hyperfiber/bluespace,
					prob(2);/obj/item/selectable_item/chemistrykit/size,
					prob(2);/obj/item/selectable_item/chemistrykit/gender,
					prob(2);/obj/item/clothing/gloves/bluespace/emagged,
					prob(1);/obj/item/clothing/suit/storage/vest/heavy/merc,
					prob(1);/obj/item/sleevemate,
					prob(1);/obj/item/bodysnatcher,
					prob(1);/obj/item/mindbinder,	//CHOMPAdd
					prob(1);/obj/item/cell/hyper,
					prob(1);/obj/item/disk/nifsoft/compliance,
					prob(1);/obj/item/implanter/compliance,
					prob(1);/obj/item/material/knife/tacknife,
					prob(1);/obj/item/storage/box/survival/space,
					prob(1);/obj/item/storage/secure/briefcase/trashmoney,
					prob(1);/obj/item/survivalcapsule/popcabin,
					prob(1);/obj/item/reagent_containers/syringe/steroid,
					prob(2);/obj/item/capture_crystal,
					prob(1);/obj/item/perfect_tele,
					prob(1);/obj/item/clothing/gloves/bluespace,
					prob(2);/obj/item/reagent_containers/pill/adminordrazine,
					prob(2);/obj/item/storage/pill_bottle/adminordrazine,
					prob(2);/obj/item/storage/pill_bottle/vermicetol,
					prob(2);/obj/item/storage/pill_bottle/healing_nanites,
					prob(2);/obj/item/storage/pill_bottle/combat,
					prob(2);/obj/item/storage/pill_bottle/assorted,
					prob(2);/obj/item/storage/box/syndie_kit/voidsuit,
					prob(2);/obj/item/storage/box/syndie_kit/voidsuit/fire,
					prob(2);/obj/item/storage/box/syndie_kit/combat_armor,
					prob(2);/obj/item/inducer/hybrid,
					prob(1);/obj/item/cracker/vore,
					prob(1);/obj/item/gun/energy/mouseray,
					prob(1);/obj/item/rig/medical/equipped/fluff/rune,
					prob(1);/obj/item/rig/combat/equipped/fluff/frank,
					prob(1);/obj/item/clothing/shoes/fart_shoes,
					prob(1);/obj/item/clothing/head/cowboy/fancy/eliz,
					prob(1);/obj/item/clothing/accessory/collar/shock/bluespace/modified,
					prob(1);/obj/item/gun/energy/sizegun/backfire)

	var/obj/item/I = new path()
	return I

/obj/structure/trash_pile/proc/produce_gamma_item()
	var/path = pick_n_take(unique_gamma)
	if(!path) //Tapped out, reallocate?
		for(var/P in allocated_gamma)
			var/obj/item/I = allocated_gamma[P]
			if(QDELETED(I) || istype(I.loc,/obj/machinery/computer/cryopod))
				allocated_gamma -= P
				path = P
				break

	if(path)
		var/obj/item/I = new path()
		allocated_gamma[path] = I
		return I
	else
		return produce_beta_item()

/obj/structure/mob_spawner/mouse_nest
	name = "trash"
	desc = "A small heap of trash, perfect for mice and other pests to nest in."
	icon = 'icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	spawn_types = list(
	/mob/living/simple_mob/animal/passive/mouse= 100,
	/mob/living/simple_mob/animal/passive/cockroach = 25)
	simultaneous_spawns = 1
	destructible = 1
	spawn_delay = 5 HOUR

/obj/structure/mob_spawner/mouse_nest/Initialize(mapload)
	. = ..()
	last_spawn = rand(world.time - spawn_delay, world.time)
	icon_state = pick(
		"pile1",
		"pile2",
		"pilechair",
		"piletable",
		"pilevending",
		"brtrashpile",
		"microwavepile",
		"rackpile",
		"boxfort",
		"trashbag",
		"brokecomp")

/obj/structure/mob_spawner/mouse_nest/do_spawn(var/mob_path)
	. = ..()
	var/atom/A = get_holder_at_turf_level(src)
	A.visible_message("[.] crawls out of \the [src].")

/obj/structure/mob_spawner/mouse_nest/get_death_report(var/mob/living/L)
	..()
	last_spawn = rand(world.time - spawn_delay, world.time)
