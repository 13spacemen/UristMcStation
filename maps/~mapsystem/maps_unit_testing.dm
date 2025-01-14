/datum/map
	var/const/NO_APC = 1
	var/const/NO_VENT = 2
	var/const/NO_SCRUBBER = 4

	// Unit test vars
	var/list/apc_test_exempt_areas = list(
		/area/exoplanet             = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet/desert      = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet/grass       = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet/snow        = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet/garbage     = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet/shrouded    = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet/chlorine    = NO_SCRUBBER|NO_VENT|NO_APC
	)

	var/list/area_coherency_test_exempt_areas = list(
		/area/space,
		/area/exoplanet,
		/area/exoplanet/desert,
		/area/exoplanet/grass,
		/area/exoplanet/snow,
		/area/exoplanet/garbage,
		/area/exoplanet/shrouded,
		/area/exoplanet/chlorine
	)
	var/list/area_coherency_test_subarea_count = list()

	// These areas are used specifically by code and need to be broken out somehow
	var/list/area_usage_test_exempted_areas = list(
		/area/beach,
		/area/boarding_ship,
		/area/centcom,
		/area/centcom/holding,
		/area/centcom/specops,
		/area/chapel,
		/area/hallway,
		/area/jungleoutpost,
		/area/maintenance,
		/area/medical,
		/area/medical/virology,
		/area/medical/virologyaccess,
		/area/overmap,
		/area/planet,
		/area/rnd,
		/area/rnd/xenobiology,
		/area/rnd/xenobiology/xenoflora,
		/area/rnd/xenobiology/xenoflora_storage,
		/area/security,
		/area/security/prison,
		/area/security/brig,
		/area/skipjack_station,
		/area/skipjack_station/start,
		/area/shuttle,
		/area/shuttle/escape,
		/area/shuttle/escape/centcom,
		/area/shuttle/specops,
		/area/shuttle/specops/centcom,
		/area/turbolift,
		/area/supply,
		/area/syndicate_mothership,
		/area/syndicate_mothership/elite_squad,
		/area/wizard_station,
		/area/template_noop,
	)

	var/list/area_usage_test_exempted_root_areas = list(
		/area/map_template,
		/area/exoplanet,
		/area/infestation,
		/area/jungleoutpost,
		/area/planet/jungle,
		/area/shuttle/scom,
		/area/shuttle/assault,
		/area/shuttle/infestation,
		/area/shuttle/event1,
		/area/shuttle/event2,
		/area/shuttle/train,
		/area/shuttle/naval1,
		/area/shuttle/syndicate_elite,
		/area/scom,
		/area/awaymission,
	)

	var/list/area_purity_test_exempt_areas = list()