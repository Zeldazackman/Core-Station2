//////////////////
// AR HUD Overlays
/datum/nifsoft/ar_civ
	name = "AR Overlay (Civ)"
	desc = "Provides a general identification and health status overlay on your vision with no frills."
	list_pos = NIF_CIVILIAN_AR
	cost = 50
	planes_enabled = list(VIS_CH_ID,VIS_CH_HEALTH_VR,VIS_AUGMENTED)
	vision_flags = (NIF_V_AR_CIVILIAN)
	incompatible_with = list(NIF_MEDICAL_AR,NIF_SECURITY_AR,NIF_ENGINE_AR,NIF_SCIENCE_AR,NIF_OMNI_AR)

/datum/nifsoft/ar_med
	name = "AR Overlay (Med)"
	desc = "Like the civilian model, but provides medical records access and virus database lookup."
	list_pos = NIF_MEDICAL_AR
	cost = 75
	access = access_medical
	planes_enabled = list(VIS_CH_ID,VIS_CH_HEALTH_VR,VIS_CH_STATUS_R,VIS_CH_BACKUP,VIS_AUGMENTED)
	vision_flags = (NIF_V_AR_MEDICAL)
	incompatible_with = list(NIF_CIVILIAN_AR,NIF_SECURITY_AR,NIF_ENGINE_AR,NIF_SCIENCE_AR,NIF_OMNI_AR)

/datum/nifsoft/ar_sec
	name = "AR Overlay (Sec)"
	desc = "Like the civilian model, but provides access to arrest status and security records."
	list_pos = NIF_SECURITY_AR
	cost = 75
	access = access_security
	planes_enabled = list(VIS_CH_ID,VIS_CH_HEALTH_VR,VIS_CH_WANTED,VIS_AUGMENTED)
	vision_flags = (NIF_V_AR_SECURITY)
	incompatible_with = list(NIF_CIVILIAN_AR,NIF_MEDICAL_AR,NIF_ENGINE_AR,NIF_SCIENCE_AR,NIF_OMNI_AR)

/datum/nifsoft/ar_eng
	name = "AR Overlay (Eng)"
	desc = "Like the civilian model, but provides ... well, nothing. For now."
	list_pos = NIF_ENGINE_AR
	cost = 50
	access = access_engine
	planes_enabled = list(VIS_CH_ID,VIS_CH_HEALTH_VR,VIS_AUGMENTED)
	vision_flags = (NIF_V_AR_ENGINE)
	incompatible_with = list(NIF_CIVILIAN_AR,NIF_MEDICAL_AR,NIF_SECURITY_AR,NIF_SCIENCE_AR,NIF_OMNI_AR)

/datum/nifsoft/ar_science
	name = "AR Overlay (Sci)"
	desc = "Like the civilian model, but provides ... well, nothing. For now."
	list_pos = NIF_SCIENCE_AR
	cost = 50
	access = access_research
	planes_enabled = list(VIS_CH_ID,VIS_CH_HEALTH_VR,VIS_AUGMENTED)
	vision_flags = (NIF_V_AR_SCIENCE)
	incompatible_with = list(NIF_CIVILIAN_AR,NIF_MEDICAL_AR,NIF_SECURITY_AR,NIF_ENGINE_AR,NIF_OMNI_AR)

/datum/nifsoft/ar_omni
	name = "AR Overlay (Omni)"
	desc = "Like the civilian model, but provides most of the features of the medical and security overlays as well."
	list_pos = NIF_OMNI_AR
	cost = 75
	access = access_captain
	planes_enabled = list(VIS_CH_ID,VIS_CH_HEALTH_VR,VIS_CH_STATUS_R,VIS_CH_BACKUP,VIS_CH_WANTED,VIS_AUGMENTED)
	vision_flags = (NIF_V_AR_OMNI)
	incompatible_with = list(NIF_CIVILIAN_AR,NIF_MEDICAL_AR,NIF_SECURITY_AR,NIF_ENGINE_AR,NIF_SCIENCE_AR)

//////////////
// Misc Vision
/datum/nifsoft/corrective
	name = "Corrective AR"
	desc = "Subtly alters perception to compensate for cataracts and retinal misalignment, among other common disabilities."
	list_pos = NIF_CORRECTIVE_GLASS
	cost = 10
	vision_flags = (NIF_V_CORRECTIVE)

/datum/nifsoft/uvblocker
	name = "Nictating Membrane"
	desc = "A synthetic nictating membrane (aka 'third eyelid') that protects the eyes from UV or hostile atmospheres. Does not protect from photonic stun weapons."
	list_pos = NIF_UVFILTER
	cost = 25
	vision_flags = (NIF_V_UVFILTER)

/datum/nifsoft/flashprot
	name = "Responsive Filter"
	desc = "Enables a high-speed shielding response to intense light, such as flashes, to block them."
	list_pos = NIF_FLASHPROT
	cost = 30
	access = access_security
	vision_flags = (NIF_V_FLASHPROT)

////////////////
// Goggle-alikes
/datum/nifsoft/mesons
	name = "Meson Scanner"
	desc = "Similar to the worn Optical Meson Scanner Goggles, these allow you to see the base structure and terrain through walls."
	list_pos = NIF_MESONS
	cost = 50
	access = access_engine
	tick_flags = NIF_ACTIVETICK
	planes_enabled = list(VIS_FULLBRIGHT, VIS_MESONS)
	vision_flags = (NIF_V_MESONS)
	vision_flags_mob = SEE_TURFS
	incompatible_with = list(NIF_MATERIAL,NIF_THERMALS,NIF_NIGHTVIS)
	vision_exclusive = TRUE

/datum/nifsoft/mesons/life()
	if((. = ..()))
		var/mob/living/carbon/human/H = nif.human
		if(H.client)
			H.client.screen |= GLOB.global_hud.meson

/datum/nifsoft/material
	name = "Material Scanner"
	desc = "Similar to the worn Optical Material Scanner Goggles, these allow you to see objects through walls."
	list_pos = NIF_MATERIAL
	cost = 50
	access = access_research
	tick_flags = NIF_ACTIVETICK
	planes_enabled = list(VIS_FULLBRIGHT)
	vision_flags = (NIF_V_MATERIAL)
	vision_flags_mob = SEE_OBJS
	incompatible_with = list(NIF_MESONS,NIF_THERMALS,NIF_NIGHTVIS)
	vision_exclusive = TRUE

/datum/nifsoft/material/life()
	if((. = ..()))
		var/mob/living/carbon/human/H = nif.human
		if(H.client)
			H.client.screen |= GLOB.global_hud.material

/datum/nifsoft/thermals
	name = "Thermal Scanner"
	desc = "Similar to the worn Thermal Goggles, these allow you to see heat-emitting creatures through walls."
	list_pos = NIF_THERMALS
	cost = 100
	illegal = TRUE
	access = 999
	tick_flags = NIF_ACTIVETICK
	planes_enabled = list(VIS_FULLBRIGHT, VIS_CLOAKED)
	vision_flags = (NIF_V_THERMALS)
	vision_flags_mob = SEE_MOBS
	incompatible_with = list(NIF_MESONS,NIF_MATERIAL,NIF_NIGHTVIS)
	vision_exclusive = TRUE

/datum/nifsoft/thermals/life()
	if((. = ..()))
		var/mob/living/carbon/human/H = nif.human
		if(H.client)
			H.client.screen |= GLOB.global_hud.thermal

/datum/nifsoft/nightvis
	name = "Low-Light Amp"
	desc = "Similar to the worn Night Vision Goggles, these allow you to see in complete darkness."
	list_pos = NIF_NIGHTVIS
	cost = 50
	access = access_security
	tick_flags = NIF_ACTIVETICK
	planes_enabled = list(VIS_FULLBRIGHT)
	vision_flags = (NIF_V_NIGHTVIS)
	darkness_view = 7
	incompatible_with = list(NIF_MESONS,NIF_MATERIAL,NIF_THERMALS)
	vision_exclusive = TRUE

/datum/nifsoft/nightvis/life()
	if((. = ..()))
		var/mob/living/carbon/human/H = nif.human
		if(H.client)
			H.client.screen |= GLOB.global_hud.nvg
