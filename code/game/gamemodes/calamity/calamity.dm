#define ANTAG_TYPE_RATIO 8

/datum/game_mode/calamity
	name = "Calamity"
	round_description = "This must be a Thursday. You never could get the hang of Thursdays..."
	extended_round_description = "All Hell is about to break loose. Literally every antagonist type may spawn in this round. Hold on tight."
	config_tag = "calamity"
	required_players = 1
	votable = 0
	event_delay_mod_moderate = 0.5
	event_delay_mod_major = 0.75

/datum/game_mode/calamity/create_antagonists()

	shuffle(GLOB.all_antag_types) // This is probably the only instance in the game where the order will be important.
	var/i = 1
	var/grab_antags = round(num_players()/ANTAG_TYPE_RATIO)+1
	for(var/antag_id in GLOB.all_antag_types)
		if(i > grab_antags)
			break
		antag_tags |= antag_id
		i++
	..()

/datum/game_mode/calamity/check_victory()
	to_world(span_world(span_large("This terrible, terrible day has finally ended!")))

#undef ANTAG_TYPE_RATIO
