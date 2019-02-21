////////////////
//main shuttle//
////////////////

/area/exploration_shuttle
	name = "\improper Trajan"
	icon_state = "shuttlered"
	base_turf = /turf/simulated/floor/plating
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/exploration_shuttle/cockpit
	name = "\improper Trajan - Cockpit"

/area/exploration_shuttle/atmos
	name = "\improper Trajan - Atmos Compartment"

/area/exploration_shuttle/power
	name = "\improper Trajan - Power Compartment"

/area/exploration_shuttle/main
	name = "\improper Trajan - Main Compartment"

/area/exploration_shuttle/cargo
	name = "\improper Trajan - Cargo Bay"

/obj/machinery/computer/shuttle_control/explore/trajan
	name = "Trajan Control Console"
	shuttle_tag = "Trajan"

/datum/shuttle/autodock/overmap/exploration_shuttle
	name = "Trajan"
	move_time = 90
	shuttle_area = list(/area/exploration_shuttle/cockpit, /area/exploration_shuttle/atmos, /area/exploration_shuttle/power, /area/exploration_shuttle/main, /area/exploration_shuttle/cargo)
	dock_target = "calypso_shuttle"
	current_location = "nav_hangar_trajan"
	landmark_transition = "nav_transit_trajan"
	logging_home_tag = "nav_hangar_trajan"
	logging_access = access_expedition_shuttle_helm

/obj/effect/shuttle_landmark/nerva/hangar/exploration_shuttle
	name = "Trajan Hangar"
	landmark_tag = "nav_hangar_trajan"
	base_area = /area/logistics/hangar
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/nerva/deck1/exploration_shuttle
	name = "Space near First Deck"
	landmark_tag = "nav_deck1_trajan"

/obj/effect/shuttle_landmark/nerva/deck3/exploration_shuttle
	name = "Space near Third Deck"
	landmark_tag = "nav_deck3_trajan"

/obj/effect/shuttle_landmark/nerva/deck2/exploration_shuttle
	name = "Space near Second Deck"
	landmark_tag = "nav_deck2_trajan"

/obj/effect/shuttle_landmark/nerva/transit/exploration_shuttle
	name = "In transit"
	landmark_tag = "nav_transit_trajan"

//////////////
//little guy//
//////////////

/datum/shuttle/autodock/overmap/antonine
	name = "Antonine"
	warmup_time = 5
	move_time = 30
	shuttle_area = /area/antonine_hangar/start
	dock_target ="antonine_shuttle"
	current_location = "nav_hangar_antonine"
	landmark_transition = "nav_transit_antonine"
	sound_takeoff = 'sound/effects/rocket.ogg'
	sound_landing = 'sound/effects/rocket_backwards.ogg'
	fuel_consumption = 2
//	logging_home_tag = "nav_hangar_antonine"

/obj/effect/shuttle_landmark/nerva/hangar/antonine
	name = "Antonine Hangar"
	landmark_tag = "nav_hangar_antonine"
	base_area = /area/logistics/hangar
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/nerva/transit/antonine
	name = "In transit"
	landmark_tag = "nav_transit_antonine"

/obj/effect/shuttle_landmark/nerva/deck1/antonine
	name = "Space near First Deck"
	landmark_tag = "nav_deck1_antonine"

/obj/effect/shuttle_landmark/nerva/deck3/antonine
	name = "Space near Third Deck"
	landmark_tag = "nav_deck3_antonine"

/obj/effect/shuttle_landmark/nerva/deck2/antonine
	name = "Space near Second Deck"
	landmark_tag = "nav_deck2_antonine"

/area/antonine_hangar/start
	name = "\improper Antonine"
	icon_state = "shuttlered"
	requires_power = 1
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/obj/machinery/computer/shuttle_control/explore/antonine
	name = "antonine control console"
	shuttle_tag = "Antonine"

//////////
//supply//
//////////

/datum/shuttle/autodock/ferry/supply/drone
	name = "Supply Drone"
	location = 1
	warmup_time = 5
	move_time = 30
	shuttle_area = /area/supply/dock
	waypoint_offsite = "nav_cargo_start"
	waypoint_station = "nav_cargo_station"
	var/doorid = "supplyshuttledoors"

/obj/effect/shuttle_landmark/supply/away
	name = "Away"
	landmark_tag = "nav_cargo_start"

/obj/effect/shuttle_landmark/supply/station
	name = "Station"
	landmark_tag = "nav_cargo_station"
	base_area = /area/spacestations/nanotrasenspace
	base_turf = /turf/simulated/floor/reinforced

/datum/shuttle/autodock/ferry/supply/drone/arrived()
	if(location == 0)
		for(var/obj/machinery/door/blast/M in SSmachines.machinery)
			if(M.id == src.doorid)
				if(M.density)
					spawn(0)
						M.open()
						return
				else
					spawn(0)
						M.close()
						return

/datum/shuttle/autodock/ferry/supply/drone/launch()
	if(location == 0)
		for(var/obj/machinery/door/blast/M in SSmachines.machinery)
			if(M.id == src.doorid)
				if(M.density)
					spawn(0)
						M.open()
						return
				else
					spawn(0)
						M.close()
						return

	..()

////////////
//merchant//
////////////

/area/shuttle/merchant/home
	name = "\improper Merchant Ship"

/datum/shuttle/autodock/ferry/merchant
	name = "Merchant"
	warmup_time = 10
	shuttle_area = /area/shuttle/merchant/home
	waypoint_station = "nav_merchant_start"
	waypoint_offsite = "nav_merchant_out"
	dock_target = "merchant_ship_dock"

/obj/effect/shuttle_landmark/merchant/start
	name = "Merchant Base"
	landmark_tag = "nav_merchant_start"
	docking_controller = "merchant_station_dock"

/obj/effect/shuttle_landmark/merchant/out
	name = "Docking Bay"
	landmark_tag = "nav_merchant_out"
	docking_controller = "lounge_dock"

//////////////
//escape pod//
//////////////

//Some helpers because so much copypasta for pods
/datum/shuttle/autodock/ferry/escape_pod/nervapod
	category = /datum/shuttle/autodock/ferry/escape_pod/nervapod
	sound_takeoff = 'sound/effects/rocket.ogg'
	sound_landing = 'sound/effects/rocket_backwards.ogg'
	var/number

/datum/shuttle/autodock/ferry/escape_pod/nervapod/New()
	name = "Escape Pod [number]"
	dock_target = "escape_pod_[number]"
	arming_controller = "escape_pod_[number]_berth"
	waypoint_station = "escape_pod_[number]_start"
	landmark_transition = "escape_pod_[number]_internim"
	waypoint_offsite = "escape_pod_[number]_out"
	..()

/obj/effect/shuttle_landmark/escape_pod/var/number

/obj/effect/shuttle_landmark/escape_pod/start
	name = "Docked"

/obj/effect/shuttle_landmark/escape_pod/start/New()
	landmark_tag = "escape_pod_[number]_start"
	docking_controller = "escape_pod_[number]_berth"
	..()

/obj/effect/shuttle_landmark/escape_pod/transit
	name = "In transit"

/obj/effect/shuttle_landmark/escape_pod/transit/New()
	landmark_tag = "escape_pod_[number]_internim"
	..()

/obj/effect/shuttle_landmark/escape_pod/out
	name = "Escaped"

/obj/effect/shuttle_landmark/escape_pod/out/New()
	landmark_tag = "escape_pod_[number]_out"
	..()

//Pods

/datum/shuttle/autodock/ferry/escape_pod/nervapod/escape_pod1
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod1/station
	number = 1
/obj/effect/shuttle_landmark/escape_pod/start/pod1
	number = 1
	base_turf = /turf/simulated/floor/reinforced/airless
/obj/effect/shuttle_landmark/escape_pod/out/pod1
	number = 1
/obj/effect/shuttle_landmark/escape_pod/transit/pod1
	number = 1

/datum/shuttle/autodock/ferry/escape_pod/nervapod/escape_pod2
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod2/station
	number = 2
/obj/effect/shuttle_landmark/escape_pod/start/pod2
	number = 2
	base_turf = /turf/simulated/floor/plating
/obj/effect/shuttle_landmark/escape_pod/out/pod2
	number = 2
/obj/effect/shuttle_landmark/escape_pod/transit/pod2
	number = 2

/datum/shuttle/autodock/ferry/escape_pod/nervapod/escape_pod3
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod3/station
	number = 3
/obj/effect/shuttle_landmark/escape_pod/start/pod3
	number = 3
	base_turf = /turf/simulated/floor/plating
/obj/effect/shuttle_landmark/escape_pod/out/pod3
	number = 3
/obj/effect/shuttle_landmark/escape_pod/transit/pod3

/area/shuttle/escape_pod1/station
	name = "Escape Pod One"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	base_turf = /turf/simulated/floor/reinforced/airless

/area/shuttle/escape_pod2/station
	name = "Escape Pod Two"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	base_turf = /turf/simulated/floor/plating

/area/shuttle/escape_pod3/station
	name = "Escape Pod Three"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	base_turf = /turf/simulated/floor/plating

//Admin

/*/datum/shuttle/autodock/ferry/administration
	name = "Administration"
	warmup_time = 10	//want some warmup time so people can cancel.
	shuttle_area = /area/shuttle/administration/centcom
	dock_target = "admin_shuttle"
	waypoint_station = "nav_admin_start"
	waypoint_offsite = "nav_admin_out"

/obj/effect/shuttle_landmark/admin/start
	name = "Centcom"
	landmark_tag = "nav_admin_start"
	docking_controller = "admin_shuttle"
	base_area = /area/centcom
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/admin/out
	name = "Docking Bay"
	landmark_tag = "nav_admin_out"
	docking_controller = "admin_shuttle_dock_airlock"*/

//Transport

/datum/shuttle/autodock/ferry/centcom
	name = "Transport"
	location = 1
	warmup_time = 10
	shuttle_area = /area/shuttle/transport1/centcom
	dock_target = "centcom_shuttle"
	waypoint_offsite = "nav_ferry_start"
	waypoint_station = "nav_ferry_out"

/obj/effect/shuttle_landmark/ferry/start
	name = "Centcom"
	landmark_tag = "nav_ferry_start"
	docking_controller = "centcom_shuttle_bay"
	base_turf = /turf/unsimulated/floor/plating
	base_area = /area/centcom

/obj/effect/shuttle_landmark/ferry/out
	name = "Docking Bay"
	landmark_tag = "nav_ferry_out"
	docking_controller = "centcom_shuttle_dock_airlock"
	base_turf = /turf/simulated/floor/plating
	base_area = /area/hallway/centralthird

/area/shuttle/transport1/centcom
	icon_state = "shuttle"
	name = "\improper Transport Shuttle Centcom"

/obj/machinery/computer/shuttle_control/transport_shuttle
	name = "transport shuttle console"
	shuttle_tag = "Transport"

//NT rescue shuttle

/area/rescue_base
	name = "\improper Response Team Base"
	icon_state = "yellow"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/rescue_base/base
	name = "\improper Barracks"
	icon_state = "yellow"
	dynamic_lighting = 0

/area/rescue_base/start
	name = "\improper Response Team Base"
	icon_state = "shuttlered"
	base_turf = /turf/unsimulated/floor/rescue_base


//ANTAGS


//Ninja Shuttle.
/datum/shuttle/autodock/multi/antag/ninja
	name = "Ninja"
	warmup_time = 0
	destination_tags = list(
		"nav_ninja_deck1",
		"nav_ninja_deck2",
		"nav_ninja_deck3",
		"nav_away_6",
		"nav_derelict_5",
		"nav_cluster_6",
		"nav_ninja_start",
		"nav_lost_supply_base_antag",
		"nav_marooned_antag",
		"nav_smugglers_antag",
		"nav_magshield_antag",
		"nav_casino_antag",
		"nav_yacht_antag",
		"nav_slavers_base_antag",
		)
	shuttle_area = /area/ninja_dojo/start
	current_location = "nav_ninja_start"
	landmark_transition = "nav_ninja_transition"
	announcer = "ICS Nerva Sensor Array"
	arrival_message = "Attention, anomalous sensor reading detected entering vessel proximity."
	departure_message = "Attention, anomalous sensor reading detected leaving vessel proximity."


/obj/effect/shuttle_landmark/ninja/start
	name = "Clan Dojo"
	landmark_tag = "nav_ninja_start"

/obj/effect/shuttle_landmark/ninja/internim
	name = "In transit"
	landmark_tag = "nav_ninja_transition"

/obj/effect/shuttle_landmark/ninja/deck1
	name = "South of First Deck"
	landmark_tag = "nav_ninja_deck1"

/obj/effect/shuttle_landmark/ninja/deck2
	name = "Northeast of Second Deck"
	landmark_tag = "nav_ninja_deck2"

/obj/effect/shuttle_landmark/ninja/deck3
	name = "East of Third Deck"
	landmark_tag = "nav_ninja_deck3"

// Ninja areas
/area/ninja_dojo
	name = "\improper Ninja Base"
	icon_state = "green"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/ninja_dojo/dojo
	name = "\improper Clan Dojo"
	dynamic_lighting = 0

/area/ninja_dojo/start
	name = "\improper Clan Dojo"
	icon_state = "shuttlered"
	base_turf = /turf/simulated/floor/plating

//Merc

/datum/shuttle/autodock/multi/antag/mercenary
	name = "Mercenary"
	warmup_time = 0
	destination_tags = list(
		"nav_merc_deck1",
		"nav_merc_deck2",
		"nav_merc_deck3",
		"nav_away_5",
		"nav_derelict_6",
		"nav_cluster_5",
//		"nav_merc_dock",
		"nav_merc_start",
		"nav_lost_supply_base_antag",
		"nav_marooned_antag",
		"nav_smugglers_antag",
		"nav_magshield_antag",
		"nav_casino_antag",
		"nav_yacht_antag",
		"nav_slavers_base_antag",
		)
	shuttle_area = /area/syndicate_station/start
	dock_target = "merc_shuttle"
	current_location = "nav_merc_start"
	landmark_transition = "nav_merc_transition"
	announcer = "SEV Torch Sensor Array"
	home_waypoint = "nav_merc_start"
	arrival_message = "Attention, vessel detected entering vessel proximity."
	departure_message = "Attention, vessel detected leaving vessel proximity."

/obj/effect/shuttle_landmark/merc/start
	name = "Mercenary Base"
	landmark_tag = "nav_merc_start"
//	docking_controller = "merc_base"
	base_turf = /turf/unsimulated/floor/snow
	base_area = /area/syndicate_mothership

/obj/effect/shuttle_landmark/merc/internim
	name = "In transit"
	landmark_tag = "nav_merc_transition"

/*/obj/effect/shuttle_landmark/merc/dock
	name = "Docking Port"
	landmark_tag = "nav_merc_dock"
	docking_controller = "nuke_shuttle_dock_airlock"*/

/obj/effect/shuttle_landmark/merc/deck1
	name = "Northeast of First Deck"
	landmark_tag = "nav_merc_deck1"

/obj/effect/shuttle_landmark/merc/deck2
	name = "Southeast of the Second deck"
	landmark_tag = "nav_merc_deck2"

/obj/effect/shuttle_landmark/merc/deck3
	name = "South of Third deck"
	landmark_tag = "nav_merc_deck3"

/area/syndicate_mothership
	name = "\improper Mercenary Base"
	icon_state = "syndie-ship"
	requires_power = 0
	dynamic_lighting = 0

/area/syndicate_station/start
	name = "\improper Mercenary Forward Operating Base"
	icon_state = "yellow"
	requires_power = 0
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

//Skipjack

/datum/shuttle/autodock/multi/antag/skipjack
	name = "Skipjack"
	warmup_time = 0
	destination_tags = list(
		"nav_skipjack_deck1",
		"nav_skipjack_deck2",
		"nav_skipjack_deck3",
		"nav_away_7",
		"nav_derelict_7",
		"nav_cluster_7",
//		"nav_skipjack_dock",
		"nav_skipjack_start",
		"nav_lost_supply_base_antag",
		"nav_marooned_antag",
		"nav_smugglers_antag",
		"nav_magshield_antag",
		"nav_casino_antag",
		"nav_yacht_antag",
		"nav_slavers_base_antag",
		)
	shuttle_area =  /area/skipjack_station/start
	dock_target = "skipjack_shuttle"
	current_location = "nav_skipjack_start"
	landmark_transition = "nav_skipjack_transition"
	announcer = "SEV Torch Sensor Array"
	home_waypoint = "nav_skipjack_start"
	arrival_message = "Attention, vessel detected entering vessel proximity."
	departure_message = "Attention, vessel detected leaving vessel proximity."

/obj/effect/shuttle_landmark/skipjack/start
	name = "Raider Outpost"
	landmark_tag = "nav_skipjack_start"
	docking_controller = "skipjack_base"

/obj/effect/shuttle_landmark/skipjack/internim
	name = "In transit"
	landmark_tag = "nav_skipjack_transition"

/*/obj/effect/shuttle_landmark/skipjack/dock
	name = "Docking Port"
	landmark_tag = "nav_skipjack_dock"
	docking_controller = "skipjack_shuttle_dock_airlock"*/

/obj/effect/shuttle_landmark/skipjack/deck1
	name = "Northwest of First Deck"
	landmark_tag = "nav_skipjack_deck1"

/obj/effect/shuttle_landmark/skipjack/deck2
	name = "Southwest of the Second deck"
	landmark_tag = "nav_skipjack_deck2"

/obj/effect/shuttle_landmark/skipjack/deck3
	name = "Southeast of Third deck"
	landmark_tag = "nav_skipjack_deck3"

/area/skipjack_station
	name = "Raider Outpost"
	icon_state = "yellow"
	requires_power = 0


//Makes the deck management program use hangar access
/datum/nano_module/deck_management
	default_access = list(access_expedition_shuttle_helm, access_cargo, access_heads)

/////////////////////
//generic waypoints//
/////////////////////
/*
/obj/effect/shuttle_landmark/nerva/first/fore
	name = "First Deck - Fore"
	landmark_tag = "wyrm_prim_fore"

/obj/effect/shuttle_landmark/nerva/first/star
	name = "First Deck - Starboard"
	landmark_tag = "wyrm_prim_star"

/obj/effect/shuttle_landmark/nerva/first/port
	name = "First Deck - Portside"
	landmark_tag = "wyrm_prim_port"

/obj/effect/shuttle_landmark/nerva/first/aft
	name = "First Deck - Aft"
	landmark_tag = "wyrm_prim_aft"

/obj/effect/shuttle_landmark/nerva/second/fore
	name = "Second Deck- Fore"
	landmark_tag = "wyrm_sub_fore"

/obj/effect/shuttle_landmark/nerva/second/star
	name = "Second Deck - Starboard"
	landmark_tag = "wyrm_sub_star"

/obj/effect/shuttle_landmark/nerva/second/port
	name = "Second Deck - Portside"
	landmark_tag = "wyrm_sub_port"

/obj/effect/shuttle_landmark/nerva/second/aft
	name = "Second Deck - Aft"
	landmark_tag = "wyrm_sub_aft"

/obj/effect/shuttle_landmark/nerva/third/fore
	name = "Second Deck- Fore"
	landmark_tag = "wyrm_sub_fore"

/obj/effect/shuttle_landmark/nerva/third/star
	name = "Second Deck - Starboard"
	landmark_tag = "wyrm_sub_star"

/obj/effect/shuttle_landmark/nerva/third/port
	name = "Second Deck - Portside"
	landmark_tag = "wyrm_sub_port"

/obj/effect/shuttle_landmark/nerva/third/aft
	name = "Second Deck - Aft"
	landmark_tag = "wyrm_sub_aft"*/






/*/area/rescue/start
	name = "\improper Rescue Pod"
	icon_state = "shuttlered"
	requires_power = 1
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED


/obj/machinery/computer/shuttle_control/explore/lanius
	name = "Aura Control Console"
	shuttle_tag = "Aura"

/obj/machinery/computer/shuttle_control/explore/escape
	name = "Pod Control"
	shuttle_tag = "Escape Pod"

/obj/machinery/computer/shuttle_control/explore/rescue
	name = "Rescue Pod Control"
	shuttle_tag = "Rescue Pod"

/obj/machinery/computer/shuttle_control/explore/admin
	shuttle_tag = "CHANGE_ME"

/datum/shuttle/autodock/overmap/hatchling
	name = "Hatchling"
	move_time = 90
	shuttle_area = /area/hatchling/start
	dock_target = "hatchling_dock"
	current_location = "wyrm_docked_hatchling"
	landmark_transition = "nav_transit_hatchling"

/datum/shuttle/autodock/ferry/escape_pod/pod
	name = "Escape Pod"
	shuttle_area = /area/pod/start
	dock_target = "escape_pod"
	arming_controller = "escape_pod_berth"
	waypoint_station = "nav_docked_pod"
	landmark_transition = "nav_transit_pod"
	waypoint_offsite = "nav_escaped_pod"

/datum/shuttle/autodock/overmap/rescue
	name = "Rescue Pod"
	move_time = 30
	shuttle_area = /area/rescue/start
	current_location = "wyrm_docked_rescue"
	landmark_transition = "nav_transit_rescue"

/obj/effect/shuttle_landmark/pod/docked
	name = "Docking Port"
	landmark_tag = "nav_docked_pod"

/obj/effect/shuttle_landmark/wyrm/docked/hatchling
	name = "Docking Port"
	landmark_tag = "wyrm_docked_hatchling"
	docking_controller = "wyrm_docking_hatch"

/obj/effect/shuttle_landmark/wyrm/docked/rescue
	name = "Docking Port"
	landmark_tag = "wyrm_docked_rescue"

/obj/effect/shuttle_landmark/pod/transit
	name = "In transit"
	landmark_tag = "nav_transit_pod"

/obj/effect/shuttle_landmark/wyrm/transit/hatchling
	name = "In transit"
	landmark_tag = "nav_transit_hatchling"

/obj/effect/shuttle_landmark/wyrm/transit/lanius
	name = "In transit"
	landmark_tag = "nav_transit_lanius"

/obj/effect/shuttle_landmark/wyrm/transit/rescue
	name = "In transit"
	landmark_tag = "nav_transit_rescue"

/obj/effect/shuttle_landmark/pod/escaped
	name = "Escaped"
	landmark_tag = "nav_escaped_pod"*/
