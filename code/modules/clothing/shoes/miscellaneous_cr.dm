/obj/item/clothing/shoes/fart_shoes
	desc = "This was a mistake"
	name = "fart shoes"
	icon_state = "clown"
	slowdown = -1
	force = 0
	species_restricted = null
	var/list/squeak_sound = list('sound/effects/fart1.ogg'=1) //Squeak sound list. Necessary so our subtypes can have different sounds loaded into their component

/obj/item/clothing/shoes/fart_shoes/Initialize(mapload)
	.=..()
	LoadComponent(/datum/component/squeak, squeak_sound, 20*step_volume_mod)

/*/obj/item/clothing/shoes/fart_shoes/handle_movement(var/turf/walking, var/running)
	if(running)
		if(footstep >= 2)
			footstep = 0
			playsound(src, "sound/effects/fart1.ogg", 60, 1) // this will get annoying very fast.
		else
			footstep++
	else
		playsound(src, "sound/effects/fart1.ogg", 20, 1)*/