// To cut down on unneeded creation/deletion, these are global.
GLOBAL_LIST_INIT(terminal_commands, init_subtypes(/datum/terminal_command))

/datum/terminal_command
	var/name                              // Used for man
	var/man_entry                         // Shown when man name is entered. Can be a list of strings, which will then be shown on separate lines.
	var/pattern                           // Matched using regex
	var/regex_flags                       // Used in the regex
	var/regex/regex                       // The actual regex, produced from above.
	var/req_access = list()               // Stores access needed, if any

/datum/terminal_command/New()
	regex = new (pattern, regex_flags)
	..()

/datum/terminal_command/proc/check_access(mob/user)
	return has_access(req_access, user.GetAccess())

// null return: continue. "" return will break and show a blank line. Return list() to break and not show anything.
/datum/terminal_command/proc/parse(text, mob/user, datum/terminal/terminal)
	if(!findtext(text, regex))
		return
	if(!check_access(user))
		return "[name]: ACCESS DENIED"
	return proper_input_entered(text, user, terminal)

//Should not return null unless you want parser to continue.
/datum/terminal_command/proc/proper_input_entered(text, mob/user, terminal)
	return list()

/*
Subtypes
*/
/datum/terminal_command/exit
	name = "exit"
	man_entry = list("Format: exit", "Exits terminal immediately.")
	pattern = "^exit$"

/datum/terminal_command/exit/proper_input_entered(text, mob/user, terminal)
	qdel(terminal)
	return list()

/datum/terminal_command/man
	name = "man"
	man_entry = list("Format: man \[command\]", "Without command specified, shows list of available commands.", "With command, provides instructions on command use.")
	pattern = "^man"

/datum/terminal_command/man/proper_input_entered(text, mob/user, datum/terminal/terminal)
	if(text == "man")
		. = list("The following commands are available.", "Some may require additional access.")
		for(var/command in GLOB.terminal_commands)
			var/datum/terminal_command/command_datum = command
			. += command_datum.name
		return
	if(length(text) < 5)
		return "man: improper syntax. Use man \[command\]"
	text = copytext(text, 5)
	var/datum/terminal_command/command_datum = terminal.command_by_name(text)
	if(!command_datum)
		return "man: command '[text]' not found."
	return command_datum.man_entry

/datum/terminal_command/ifconfig
	name = "ifconfig"
	man_entry = list("Format: ifconfig", "Returns network adaptor information.")
	pattern = "^ifconfig$"

/datum/terminal_command/ifconfig/proper_input_entered(text, mob/user, datum/terminal/terminal)
	if(!terminal.computer.network_card)
		return "No network adaptor found."
	if(!terminal.computer.network_card.check_functionality())
		return "Network adaptor not activated."
	return "Visible tag: [terminal.computer.network_card.get_network_tag()]. Real nid: [terminal.computer.network_card.identification_id]."

/datum/terminal_command/hwinfo
	name = "hwinfo"
	man_entry = list("Format: hwinfo \[name\]", "If no slot specified, lists hardware.", "If slot is specified, runs diagnostic tests.")
	pattern = "^hwinfo"

/datum/terminal_command/hwinfo/proper_input_entered(text, mob/user, datum/terminal/terminal)
	if(text == "hwinfo")
		. = list("Hardware Detected:")
		for(var/obj/item/weapon/computer_hardware/ch in  terminal.computer.get_all_components())
			. += ch.name
		return
	if(length(text) < 8)
		return "hwinfo: Improper syntax. Use hwinfo \[name\]."
	text = copytext(text, 8)
	var/obj/item/weapon/computer_hardware/ch = terminal.computer.find_hardware_by_name(text)
	if(!ch)
		return "hwinfo: No such hardware found."
	ch.diagnostics(user)
	return "Running diagnostic protocols..."

// Sysadmin
/datum/terminal_command/relays
	name = "relays"
	man_entry = list("Format: relays", "Gives the number of active relays found on the network.")
	pattern = "^relays$"
	req_access = list(access_network)

/datum/terminal_command/relays/proper_input_entered(text, mob/user, terminal)
	return "Number of relays found: [ntnet_global.relays.len]"

/datum/terminal_command/banned
	name = "banned"
	man_entry = list("Format: banned", "Lists currently banned network ids.")
	pattern = "^banned$"
	req_access = list(access_network)

/datum/terminal_command/banned/proper_input_entered(text, mob/user, terminal)
	. = list()
	. += "The following ids are banned:"
	. += jointext(ntnet_global.banned_nids, ", ") || "No ids banned."

/datum/terminal_command/status
	name = "status"
	man_entry = list("Format: status", "Reports network status information.")
	pattern = "^status$"
	req_access = list(access_network)

/datum/terminal_command/status/proper_input_entered(text, mob/user, terminal)
	. = list()
	. += "NTnet status: [ntnet_global.check_function() ? "ENABLED" : "DISABLED"]"
	. += "Alarm status: [ntnet_global.intrusion_detection_enabled ? "ENABLED" : "DISABLED"]"
	if(ntnet_global.intrusion_detection_alarm)
		. += "NETWORK INCURSION DETECTED"

/datum/terminal_command/locate
	name = "locate"
	man_entry = list("Format: locate nid", "Attempts to locate the device with the given nid by triangulating via relays.")
	pattern = "locate"
	req_access = list(access_network)

/datum/terminal_command/locate/proper_input_entered(text, mob/user, datum/terminal/terminal)
	. = "Failed to find device with given nid. Try ping for diagnostics."
	if(length(text) < 8)
		return
	var/obj/item/modular_computer/origin = terminal.computer
	if(!origin || !origin.get_ntnet_status())
		return
	var/nid = text2num(copytext(text, 8))
	var/obj/item/modular_computer/comp = ntnet_global.get_computer_by_nid(nid)
	if(!comp || !comp.enabled || !comp.get_ntnet_status())
		return
	return "... Estimating location: [get_area(comp)]"

/datum/terminal_command/ping
	name = "ping"
	man_entry = list("Format: ping nid", "Checks connection to the given nid.")
	pattern = "^ping"
	req_access = list(access_network)

/datum/terminal_command/ping/proper_input_entered(text, mob/user, datum/terminal/terminal)
	. = list("pinging ...")
	if(length(text) < 6)
		. += "ping: Improper syntax. Use ping nid."
		return
	var/obj/item/modular_computer/origin = terminal.computer
	if(!origin || !origin.get_ntnet_status())
		. += "failed. Check network status."
		return
	var/nid = text2num(copytext(text, 6))
	var/obj/item/modular_computer/comp = ntnet_global.get_computer_by_nid(nid)
	if(!comp || !comp.enabled || !comp.get_ntnet_status())
		. += "failed. Target device not responding."
		return
	. += "ping successful."

/datum/terminal_command/ssh
	name = "ssh"
	man_entry = list("Format: ssh nid", "Opens a remote terminal at the location of nid, if a valid device nid is specified.")
	pattern = "^ssh"
	req_access = list(access_network)

/datum/terminal_command/ssh/proper_input_entered(text, mob/user, datum/terminal/terminal)
	if(istype(terminal, /datum/terminal/remote))
		return "ssh is not supported on remote terminals."
	if(length(text) < 5)
		return "ssh: Improper syntax. Use ssh nid."
	var/obj/item/modular_computer/origin = terminal.computer
	if(!origin || !origin.get_ntnet_status())
		return "ssh: Check network connectivity."
	var/nid = text2num(copytext(text, 5))
	var/obj/item/modular_computer/comp = ntnet_global.get_computer_by_nid(nid)
	if(comp == origin)
		return "ssh: Error; can not open remote terminal to self."
	if(!comp || !comp.enabled || !comp.get_ntnet_status())
		return "ssh: No active device with this nid found."
	if(comp.has_terminal(user))
		return "ssh: A remote terminal to this device is already active."
	var/datum/terminal/remote/new_term = new (user, comp, origin)
	LAZYADD(comp.terminals, new_term)
	LAZYADD(origin.terminals, new_term)
	return "ssh: Connection established."

/datum/terminal_command/proxy
	name = "proxy"
	man_entry = list(
		"Format: proxy \[-s <nid>\]",
		"Without options, displays the proxy state of network device.",
		"With -s option and no further arguments, clears proxy settings.",
		"With -s followed by nid (number), sets proxy to nid.",
		"A set proxy will tunnel all network connections through the designated device.",
		"It is recommended that the user ensure that the target device is accessible."
	)
	pattern = "^proxy"
	req_access = list(access_network)

/datum/terminal_command/proxy/proper_input_entered(text, mob/user, datum/terminal/terminal)
	var/obj/item/modular_computer/comp = terminal.computer
	if(!comp || !comp.get_ntnet_status())
		return "proxy: Error; check networking hardware."
	if(text == "proxy")
		if(!comp.network_card.proxy_id)
			return "proxy: This device is not using a proxy."
		return "proxy: This device is set to connect via proxy with nid [comp.network_card.proxy_id]."
	if(text == "proxy -s")
		if(!comp.network_card.proxy_id)
			return "proxy: Error; this device is not using a proxy."
		comp.network_card.proxy_id = null
		return "proxy: Device proxy cleared."
	var/syntax_error = "proxy: Invalid input. Enter man proxy for syntax help."
	if(length(text) < 10)
		return syntax_error
	if(copytext(text, 1, 10) != "proxy -s ")
		return syntax_error
	var/id = text2num(copytext(text, 10))
	if(!id)
		return syntax_error
	var/obj/item/modular_computer/target = ntnet_global.get_computer_by_nid(id)
	if(!target || !target.enabled || !target.get_ntnet_status())
		return "proxy: Error; cannot locate target device."
	if(target.hard_drive)
		var/datum/computer_file/data/logfile/file = target.hard_drive.find_file_by_name("proxy")
		if(!istype(file))
			file = new()
			file.filename = "proxy"
			target.hard_drive.store_file(file) // May fail, which is fine with us.
		file.stored_data += "([time_stamp()]) Proxy routing request accepted from: [comp.network_card.get_network_tag()].\[br\]"
	comp.network_card.proxy_id = id
	return "proxy: Device proxy set to [id]."