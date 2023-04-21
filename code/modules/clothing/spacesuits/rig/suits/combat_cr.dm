/obj/item/weapon/rig/medical/equipped/fluff/rune
	name = "medical hardsuit control module"
	desc = "A sleek and loaded hardsuit for nerds to make life easier."
	req_access = list()
	req_one_access = list()
	seal_delay = 5
	armor = list(melee = 40, bullet = 35, laser = 35, energy = 75, bomb = 75, bio = 100, rad = 100)
	slowdown = 0.5
	offline_vision_restriction = 1
	siemens_coefficient= 0
	seal_delay = 5
	cell_type =  /obj/item/weapon/cell/hyper

	initial_modules = list(
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/sprinter/pursuit,
		/obj/item/rig_module/grenade_launcher/metalfoam,
		/obj/item/rig_module/chem_dispenser/injector/advanced,
		/obj/item/rig_module/mounted/sizegun,
		/obj/item/rig_module/fabricator/energy_net,
		/obj/item/rig_module/mounted/phase,
		/obj/item/rig_module/teleporter,
		/obj/item/rig_module/device/defib,
		/obj/item/rig_module/datajack,
		/obj/item/rig_module/cleaner_launcher,
		/obj/item/rig_module/stealth_field,
		/obj/item/rig_module/pat_module,
		/obj/item/rig_module/rescue_pharm,
		/obj/item/rig_module/vision/multi
		)

	chest_type = /obj/item/clothing/suit/space/rig/rune
	helm_type = /obj/item/clothing/head/helmet/space/rig/rune
	boot_type = /obj/item/clothing/shoes/magboots/rig/rune
	glove_type = /obj/item/clothing/gloves/gauntlets/rig/rune

/obj/item/clothing/head/helmet/space/rig/rune
	species_restricted = null

/obj/item/clothing/suit/space/rig/rune
	species_restricted = null

/obj/item/clothing/shoes/magboots/rig/rune
	species_restricted = null

/obj/item/clothing/gloves/gauntlets/rig/rune
	species_restricted = null


/obj/item/weapon/rig/combat/equipped/fluff/frank
	name = "combat hardsuit control module"
	desc = "A sleek and dangerous hardsuit for active combat, smells faintly of violence somehow..."
	req_access = list()
	req_one_access = list()
	seal_delay = 5
	armor = list(melee = 80, bullet = 70, laser = 60, energy = 15, bomb = 80, bio = 100, rad = 60)
	slowdown = 0
	offline_vision_restriction = 1
	siemens_coefficient= 0
	seal_delay = 5
	cell_type =  /obj/item/weapon/cell/hyper

	initial_modules = list(
		/obj/item/rig_module/mounted,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/pat_module,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/chem_dispenser/injector/advanced,
		/obj/item/rig_module/rescue_pharm,
		/obj/item/rig_module/device/defib,
		/obj/item/rig_module/sprinter/pursuit,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/device/drill,
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/teleporter,
		/obj/item/rig_module/stealth_field
		)

	chest_type = /obj/item/clothing/suit/space/rig/frank
	helm_type = /obj/item/clothing/head/helmet/space/rig/frank
	boot_type = /obj/item/clothing/shoes/magboots/rig/frank
	glove_type = /obj/item/clothing/gloves/gauntlets/rig/frank

/obj/item/clothing/head/helmet/space/rig/frank
	species_restricted = null

/obj/item/clothing/suit/space/rig/frank
	species_restricted = null

/obj/item/clothing/shoes/magboots/rig/frank
	species_restricted = null

/obj/item/clothing/gloves/gauntlets/rig/frank
	species_restricted = null