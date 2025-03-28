/datum/category_item/catalogue/fauna/mimic
	name = "Aberration - Mimic"
	desc = "Classification: Mimus vorare\
	<br><br>\
	Mimics are morph creatures that share properties with the likes of prometheans. They can assume any shape, \
	provided that they retain the same volume. In order to most effectively lure prey, they most commonly \
	take the shape of chests and other objects likely to be touched by someone - though the latter is rarer \
	than the former. \
	<br>\
	Mimics prefer consuming large prey such as humans or humanoid species, however, for means of survival they \
	might resort to eating smaller prey. A meal of one or two humanoids could sustain a mimic for several \
	months at a time - the main reason that they prey on humanoids to begin with. They reproduce asexually \
	by splitting their mass, the young growing to adulthood within a few years time.\
	<br>\
	Mimics have no concerns beyond surviving and acquiring food." //CHOMPedit
	value = CATALOGUER_REWARD_HARD

/obj/structure/closet/crate/mimic
	name = "old crate"
	desc = "A rectangular steel crate. This one looks particularly unstable."
	var/mimic_chance = 30
	var/mimic_active = TRUE
	var/nest = null	//CHOMPAdd

/obj/structure/closet/crate/mimic/open()
	if(src.opened)
		return 0
	if(!src.can_open())
		return 0

	//CHOMPAdd Start
	if(istype(nest, /obj/structure/mob_spawner))
		var/obj/structure/mob_spawner/S = nest
		S.get_used_report(src)
	//CHOMPAdd End

	if(mimic_active)
		mimic_active = FALSE
		if(prob(mimic_chance))
			var/mob/living/simple_mob/vore/aggressive/mimic/new_mimic = new(loc, src)
			visible_message(span_bolddanger("[new_mimic] suddenly growls as it turns out to be a mimic!"))
			forceMove(new_mimic)
			new_mimic.real_crate = src
			new_mimic.name = name
			new_mimic.desc = desc
			//new_mimic.icon = icon CHOMPEdit
			new_mimic.icon_state = "open"
			new_mimic.icon_living = "open"
		else
			return ..()
	else
		return ..()

/obj/structure/closet/crate/mimic/ex_act(severity)
	for(var/obj/O in src.contents)
		qdel(O)
	qdel(src)
	return

/obj/structure/closet/crate/mimic/damage(var/damage)
	if(contents.len)
		visible_message(span_bolddanger("[src] makes out a crunchy noise as its contents are destroyed!"))
		for(var/obj/O in src.contents)
			qdel(O)
	..()

/obj/structure/closet/crate/mimic/safe
	mimic_chance = 0
	mimic_active = FALSE

/obj/structure/closet/crate/mimic/guaranteed
	mimic_chance = 100

/obj/structure/closet/crate/mimic/dangerous
	mimic_chance = 70

/obj/structure/closet/crate/mimic/cointoss
	mimic_chance = 50

/mob/living/simple_mob/vore/aggressive/mimic
	name = "crate"
	desc = "A rectangular steel crate."

	//CHOMPEdit Start
	icon_state = "open"
	icon_living = "open"
	icon = 'modular_chomp/icons/mob/animal_ch.dmi'
	// CHOMPEdit End

	faction = FACTION_MIMIC

	maxHealth = 125
	health = 125
	movement_cooldown = 3

	response_help = "touches"
	response_disarm = "pushes"
	response_harm = "hits"

	melee_damage_lower = 7
	melee_damage_upper = 15
	attacktext = list("attacked")
	attack_sound = 'sound/weapons/bite.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	ai_holder_type = /datum/ai_holder/mimic

	var/obj/structure/closet/crate/real_crate

	var/knockdown_chance = 10 //Stubbing your toe on furniture hurts.

	showvoreprefs = 0 //Hides mechanical vore prefs for mimics. You can't see their gaping maws when they're just sitting idle.

/mob/living/simple_mob/vore/aggressive/mimic
	tt_desc = "Mimus vorare"
	catalogue_data = list(/datum/category_item/catalogue/fauna/mimic)
	vore_active = 1
	vore_pounce_chance = 10
	swallowTime = 3 SECONDS
	vore_capacity = 1
	vore_default_mode = DM_DIGEST
	can_be_drop_prey = FALSE //CHOMP Add


/mob/living/simple_mob/vore/aggressive/mimic/init_vore()
	if(!voremob_loaded)
		return
	if(LAZYLEN(vore_organs))
		return
	. = ..()
	var/obj/belly/B = vore_selected
	B.vore_sound = "Tauric Swallow"
	B.release_sound = "Pred Escape"
	B.fancy_vore = 1
	B.vore_verb = "greedily devour"
	B.contamination_color = "red"
	B.contamination_flavor = "Arcid"
	B.belly_fullscreen = "yet_another_tumby"
	B.colorization_enabled = FALSE

/datum/ai_holder/mimic
	wander = FALSE
	hostile = TRUE

/mob/living/simple_mob/vore/aggressive/mimic/apply_melee_effects(var/atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(prob(knockdown_chance))
			L.Weaken(3)
			L.visible_message(span_danger("\The [src] knocks down \the [L]!"))

/mob/living/simple_mob/vore/aggressive/mimic/will_show_tooltip()
	return FALSE

/mob/living/simple_mob/vore/aggressive/mimic/death()
	..()
	if(real_crate)
		real_crate.forceMove(loc)
	else
		new/obj/structure/closet/crate(loc)
	real_crate = null
	qdel(src)
