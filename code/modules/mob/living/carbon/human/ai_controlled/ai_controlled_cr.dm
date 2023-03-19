/mob/living/carbon/human/ai_controlled/jane
	name = "Nameless Jane"
	ai_holder_type = /datum/ai_holder/simple_mob/passive

	generate_species = SPECIES_HUMAN

	generate_gender = TRUE
	identifying_gender = FEMALE

	faction = "neutral"
	to_wear_hair = "Bedhead Long"
	to_wear_helmet = null
	to_wear_glasses = null
	to_wear_mask = null
	to_wear_l_radio = /obj/item/device/radio/headset/headset_rob
	to_wear_r_radio = null
	to_wear_uniform = /obj/item/clothing/under/fluff/latexmaid
	to_wear_suit = null
	to_wear_gloves = null
	to_wear_shoes = /obj/item/clothing/shoes/sandal
	to_wear_belt = null
	to_wear_l_pocket = null
	to_wear_r_pocket = null
	to_wear_back = null
	to_wear_id_type = null
	to_wear_r_hand = null

/mob/living/carbon/human/ai_controlled/jane/Initialize()
	. = ..()
	name = species.get_random_name(gender)