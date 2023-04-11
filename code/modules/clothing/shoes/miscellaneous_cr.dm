/obj/item/clothing/shoes/fart_shoes
	desc = "This was a mistake"
	name = "fart shoes"
	icon_state = "clown"
	slowdown = -1
	force = 0
	var/footstep = 1	//used for squeeks whilst walking
	species_restricted = null

/obj/item/clothing/shoes/fart_shoes/handle_movement(var/turf/walking, var/running)
	if(running)
		if(footstep >= 2)
			footstep = 0
			playsound(src, "sound/effects/fart1.ogg", 60, 1) // this will get annoying very fast.
		else
			footstep++
	else
		playsound(src, "sound/effects/fart1.ogg", 20, 1)