/mob/living/simple_mob/vore/weretiger
	name = "weretiger"
	desc = "A big scary, albino were-tiger! At least they seem decently mannered..."
	tt_desc = "Tigris Thropus Album"

	icon_state = "bigcat"
	icon_living = "bigcat"
	icon_dead = "bigcat_dead"
	icon_rest = null
	icon = 'icons/mob/bigcat.dmi'

	faction = FACTION_PANTHER
	maxHealth = 150
	health = 150
	movement_cooldown = -1

	response_help = "pats"
	response_disarm = "gently pushes aside"
	response_harm = "hits"

	harm_intent_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 20
	attacktext = list("mauled")

	say_list_type = /datum/say_list/weretiger
	ai_holder_type = /datum/ai_holder/simple_mob/retaliate

	pixel_x = -16
	default_pixel_x = -16

	has_hands = 1

	can_be_drop_prey = FALSE //CHOMP Add
	allow_mind_transfer = TRUE

// Nomnomn
/mob/living/simple_mob/vore/weretiger
	vore_active = 1
	vore_bump_chance = 10
	vore_bump_emote	= "sneaks up on"
	vore_pounce_chance = 50
	vore_default_mode = DM_HOLD
	vore_icons = SA_ICON_LIVING

/mob/living/simple_mob/vore/weretiger/init_vore()
	if(!voremob_loaded)
		return
	if(LAZYLEN(vore_organs))
		return
	. = ..()
	var/obj/belly/B = vore_selected
	B.vore_sound = "Tauric Swallow"
	B.release_sound = "Pred Escape"
	B.fancy_vore = 1
	B.vore_verb = "slurp"
	B.contamination_color = "yellow"
	B.contamination_flavor = "Arcid"

/datum/say_list/weretiger
	speak = list("Gruff.","ROAR!","Growl.")
	emote_hear = list("growls!","grunts.")
	emote_see = list("pads around noisily.","scratches the floor thoroughly.")
