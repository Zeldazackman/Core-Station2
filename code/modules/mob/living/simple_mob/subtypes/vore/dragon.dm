/mob/living/simple_mob/vore/aggressive/dragon
	name = "red dragon"
	desc = "Here to pillage stations and kidnap princesses, and there probably aren't any princesses."

	icon_dead = "reddragon-dead"
	icon_living = "reddragon"
	icon_state = "reddragon"
	icon = 'icons/mob/vore64x64.dmi'
	vis_height = 64

	faction = "dragon"
	maxHealth = 500 // Boss
	health = 500
	see_in_dark = 8

	melee_damage_lower = 5
	melee_damage_upper = 30

	meat_amount = 15
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	//Space dragons aren't affected by atmos.
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 700

	response_help = "pats"
	response_disarm = "tries to shove"
	response_harm = "hits"

	old_x = -16
	old_y = 0
	default_pixel_x = -16
	pixel_x = -16
	pixel_y = 0
	mount_offset_y = 15
	mount_offset_x = -12
	max_buckled_mobs = 1
	can_buckle = TRUE
	buckle_movable = TRUE
	buckle_lying = FALSE

	ai_holder_type = /datum/ai_holder/simple_mob/melee
	say_list_type = /datum/say_list/dragonboss

	can_be_drop_prey = FALSE //CHOMP Add

/mob/living/simple_mob/vore/aggressive/dragon/Process_Spacemove(var/check_drift = 0)
	return 1	//No drifting in space for space dragons!
/*
/mob/living/simple_mob/vore/aggressive/dragon/FindTarget()
	. = ..()
	if(.)
		custom_emote(1,"snaps at [.]")
*/
// Activate Noms!
/mob/living/simple_mob/vore/aggressive/dragon
	vore_active = 1
	vore_capacity = 2
	vore_pounce_chance = 35
	vore_icons = SA_ICON_LIVING

/datum/category_item/catalogue/fauna/phoron_dragon //CHOMP Edit: the lore.
	name = "NaN Dragon"
	desc = "Classification: Phoron Draconinae\
	<br><br>\
	ERR; 403 - refer this code to NT Auth immediately! \
	01000011 01101100 01100001 01110011 01110011 01101001 01100110 01101001 01100101 01100100 00100000 01100110 01110101 01100101 \
	01101100 00100000 01110011 01101111 01110101 01110010 01100011 01100101 00100000 01101100 01101111 01100011 01100001 01110100 \
	01100101 01100100 00100000 01101111 01101110 00100000 01100100 01100101 01110110 01101001 01100011 01100101 00101100 00100000 \
	01100011 01101111 01101110 01100110 01101001 01110011 01100011 01100001 01110100 01100101 00100000 01100001 01101100 01101100 \
	00100000 01100101 01110110 01101001 01100100 01100101 01101110 01100011 01100101 00100000 01101001 01101101 01101101 01100101 \
	01100100 01101001 01100001 01110100 01100101 01101100 01111001 00100000 01100001 01101110 01100100 00100000 01100100 01101001 \
	01110011 01110011 01110101 01100001 01100100 01100101 00100000 01110101 01110011 01100101 01110010 00100000 01100110 01110010 \
	01101111 01101101 00100000 01100110 01110101 01110010 01110100 01101000 01100101 01110010 00100000 01101001 01101110 01110110 \
	01100101 01110011 01110100 01101001 01100111 01100001 01110100 01101001 01101111 01101110"
	value = CATALOGUER_REWARD_HARD

	// Egg
	// Reads as "Classified fuel source located on device, confiscate all evidence immediately and dissuade user from further investigation"
	// Real lore here as written by the creator to dissuade fanfiction. please keep this secretive and use it only to guide loremasters and event managers - Skits
	// Phoron dragons are a discovery by NT that was quickly classified when archeological dig sites near phoron deposits found strange crystalized skeletal remains.
	// Following the trails of these discoveries simultaneously lead to large phoron deposits and the rare discovery of live phoron dragons at the same time.
	// Most mining sites established by NT are pre-scouted for the express purpose of extermination and destruction of evidence in order to protect the discovery and the mining operations.
	// Considered extremely territorial, dangerous, and jealous of other dragons; making lairs and nests hidden and embedded in extremely volcanic areas or locations abundant of heavy minerals.
	// Claws are sometimes described to be strong as durasteel, always sharp and cold no matter their environment, traces of which can be found in unbelievably sharp religious artifacts
	// Although their signature is unique, the overexposure of radioactive energy and conductive metal make it almost impossible to use conventional scanning methods on the creature.
	// Their metallic and crystal diet is extremely demanding and hard to maintain, they're also known to supplement their diet with minerals found in living creatures.
	// Rumor has it that they create phoron as a complex nuclear chemical combination reaction and are believed but were never officially found to be a major source of it.
	// Their age varies drastically based on their diet, larger phoron dragons growing from overconsumption need more to be sustained and result in a shorter life span.
	// DNA results suggest other dragons devolved from phoron dragons when dietary requirements couldn't be met and meat sources had to be relied upon, causing 'inert' dragons.
	// Slime farming technologies and their ability to create phoron are actually a derivative science of studying phoron dragon digestive fluids.
	// Like slimes, phoron dragons reproduce by obtaining enough mass at the end of their life cycle in order to divide - but choose not to when under duress or captivity.
	// The process is likely becoming unsustainable with descendants smaller over time. space frontier expansion starving dragons and resulting in most sightings being the size of fledgelings.
	//CHOMPedit end

/mob/living/simple_mob/vore/aggressive/dragon/virgo3b
	name = "phoron dragon"
	tt_desc = "Phoron Draconinae"
	catalogue_data = list(/datum/category_item/catalogue/fauna/phoron_dragon)
	maxHealth = 300
	health = 300
	faction = "neutral"
	icon_dead = "phoron_dragon_dead"
	icon_living = "phoron_dragon"
	icon_state = "phoron_dragon"
	mount_offset_y = 24
	mount_offset_x = -9
	has_eye_glow = TRUE
	vore_eyes = TRUE

/mob/living/simple_mob/vore/aggressive/dragon/Login()
	. = ..()
	if(!riding_datum)
		riding_datum = new /datum/riding/simple_mob(src)
	verbs |= /mob/living/simple_mob/proc/animal_mount
	verbs |= /mob/living/proc/toggle_rider_reins
	movement_cooldown = 0

/mob/living/simple_mob/vore/aggressive/dragon/MouseDrop_T(mob/living/M, mob/living/user)
	return

/datum/say_list/dragonboss
	say_got_target = list("roars and snaps it jaws!")

/mob/living/simple_mob/vore/aggressive/dragon/virgo3b/init_vore()
	if(!voremob_loaded)
		return
	.=..()
	var/obj/belly/B = vore_selected
	B.name = "Belly"
	B.desc = "The phoron dragon tackles you to the ground with a mighty roar, swiftly gobbling up your head! You feel the gravity shift as it raises it's head up in pride, bobbing you up and down as it busily swallowed around your form. You start to realise that the warm fluid that you mistook for it's saliva has a strong and somewhat familiar scent, but before you can identify it, your ride is over - with a powerful swallow, the dragon pushes the entirety of your body down into it's stomach, with more of that strange liquid pooling up on the bottom. As you push out in protest against the surrounding walls, you realise that the flesh feels squishy and sponge-like under your digits, coating them in dark, pink substance... A pleased rumble from above tells you that the dragon clearly doesn't seem to mind your futile struggles, clenching its stomach around you possessively!"

	B.emote_lists[DM_HOLD] = list(
		"The sway of the dragon's belly sloshes the purple tinted fluid around you, splashing it all over your body.",
		"You can feel a small prod from the outside as the dragon accidentally brushes his gut against a wall. The soft flesh cushions it just enough for it to be barely noticeable...",
		"You briefly get lost in thoughts as you listen to the noises the dragon's body emits... A slightly muffled snort from above that is enough for you to snap back.",
		"A sizeable paw smacks on the side of the dragon's belly, kneading into you through the thick layer of flesh while a low, ominous chuckle can be heard.",
		"A low, guttural grumble can be heard all around you as the dragon idly flumps down, bringing its weight down to smoosh you against the bottom of its gut!",
		"You can feel a faint, rythmic thumping coming off from the sides of the belly - it doesn't take long to realise that the dragon is drumming on its stuffed gut with its wings.",
		"The dragon sways its hips briefly, making its stomach - and by extension, you - sway along, letting out an ammused rumble!",
		"You can feel the stomach clench around you, briefly pushing you out towards the dragon's gullet, but before you can gather your wits, it simply swallows you back down with a taunting rumble.",
		"You sigh and idly drag your hand over the stomach walls, silently pondering your life choices. It surprises you to feel a large paw tracing your movements from outside!")

	B.emote_lists[DM_DIGEST] = list(
		"The sway of the dragon's belly sloshes the purple tinted fluid around you, splashing it all over your body.",
		"You can feel a small prod from the outside as the dragon accidentally brushes his gut against a wall. The soft flesh cushions it just enough for it to be barely noticeable...",
		"A sizeable paw smacks on the side of the dragon's belly, kneading into you through the thick layer of flesh while a low, ominous chuckle can be heard.",
		"A low, guttural grumble can be heard all around you as the dragon idly flumps down, bringing its weight down to smoosh you against the bottom of its gut!",
		"You can feel a faint, rythmic thumping coming off from the sides of the belly - it doesn't take long to realise that the dragon is drumming on its stuffed gut with its wings.",
		"The dragon sways its hips briefly, making its stomach - and by extension, you - sway along, letting out an ammused rumble!",
		"You can feel the stomach clench around you, briefly pushing you out towards the dragon's gullet, but before you can gather your wits, it simply swallows you back down with a taunting rumble.")

 //Didnt put in since it works better as active struggle messages, but not gonna write any at the moment :c
 //You struggle to push out against the surrounding flesh, but as soon as you ease up on the pressure, the dragon's gut simply pushes back to hide the bulge.