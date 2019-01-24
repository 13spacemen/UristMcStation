/obj/machinery/computer/combatcomputer
	name = "weapons control computer"
	desc = "the control centre for the ship's weapons systems."
	anchored = 1
	var/shields = 0 //update this with the actual shields
	var/list/linkedweapons = list() //put the weapons in here on their init
	var/shipid = null
	var/target = null
	var/obj/effect/overmap/ship/combat/homeship

/obj/machinery/computer/combatcomputer/attack_hand(user as mob)
	if(..(user))
		return
	if(!allowed(user))
		to_chat(user, "<span class='warning'>Access Denied.</span>")
		return 1

//	user.set_machine(src)
	interact(user)
//	ui_interact(user)

/obj/machinery/computer/combatcomputer/Topic(href, href_list)
	if(..())
		return

//	user.set_machine(src)

/obj/machinery/computer/combatcomputer/nerva //different def just in case we have multiple ships that do combat. although, i think i might keep the cargo ship noncombat, fluff it as it being too small, slips right by the enemies. i dunno
	name = "ICS Nerva Combat Computer"
	shipid = "nerva"