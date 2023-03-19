/obj/item/clothing/head/cowboy/fancy/eliz
	name = "extra fancy cowboy hat"
	desc = "An extra special, extra nerdy black leather hat."
	icon_state = "cowboy_8"
	flash_protection = FLASH_PROTECTION_MAJOR
	armor = list(melee = 60, bullet = 60, laser = 60,energy = 30, bomb = 35, bio = 0, rad = 20)

/obj/item/clothing/head/cowboy/fancy/eliz/attack_self(mob/user as mob)
	playsound(src, 'modular_core/sound/woody.ogg', 50, 1)
	visible_message("<span class='danger'>\The air around the hat distorts for a moment before unleashing a mist of cherry flavoured lube!.</span>")
