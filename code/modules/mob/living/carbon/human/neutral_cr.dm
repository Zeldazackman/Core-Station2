/datum/trait/neutral/vent_crawler
	name = "Vent Crawler"
	desc = "Your body is fexible enough to somehow manage to clamber into a vent albeit at a slower pace than most things used to such tight environments."
	cost = 0
	custom_only = FALSE

/datum/trait/neutral/vent_crawler/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/ventcrawl
/*
/datum/trait/neutral/selfsurgery
	name = "Self Surgery"
	desc = "You know your own body inside and out well enough to the extent wherein going under the blade by your own hand doesn't seem so crazy..."
	cost = 0
	custom_only = FALSE

/datum/trait/neutral/selfsurgery/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/toggle_selfsurgery
*/