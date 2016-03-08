//Holds items added specifically for the Paranoia mode

//Jet Fuel: silly replacement for C4 as a proof-of-concept
/obj/item/weapon/storage/box/syndie_kit/jetfuel
	name = "jet fuel kit"
	desc = "Certified chemical demolitions kit. May or may not melt steel beams."

/obj/item/weapon/storage/box/syndie_kit/jetfuel/New()
	..()
	new /obj/item/weapon/reagent_containers/glass/beaker/vial/random/jetfuel(src)

/obj/item/weapon/reagent_containers/glass/beaker/vial/random/jetfuel
	random_reagent_list = list(
		list("fuel" = 15, "thermite" = 15)	= 9,
		list("fuel" = 30)	 = 1,) //10% chance, the mix cannot, in fact, melt steel beams.

/obj/item/weapon/reagent_containers/glass/beaker/vial/random/jetfuel/New()
	..()
	desc = "Contains jet fuel. Warning: results may vary!"

/obj/item/weapon/conspiracyintel
	name = "intel"
	desc = "A file containing top-secret data."
	gender = NEUTER
	icon = 'icons/urist/items/misc.dmi'
	icon_state = "folder"
	item_state = "paper"
	throwforce = 0
	w_class = 2
	throw_range = 2
	throw_speed = 1
	layer = 4
	pressure_resistance = 1
	var/value = 2 //how many TC it grants
	var/upload_id //for persistent uploads
	var/basedesc = "A file containing top-secret data."
	var/faction = "Broken Code Initiative"

/obj/item/weapon/conspiracyintel/New()
	..()
	var/datatype = pick("blueprints","financial records","operational reports","experimental data","access codes","personnel files")
	var/valuedesc
	value = pick(2,4,6)
	switch(value)
		if(2) valuedesc = "confidential"
		if(4) valuedesc = "secret"
		if(6) valuedesc = "top-secret"

	desc = "A file containing \a [valuedesc] [datatype]."
	basedesc = desc
	if(faction)
		desc = "[basedesc] It seems to concern the assets of \the [faction]."

		/*icon = 'icons/obj/bureaucracy.dmi' //reenable this for faction-specific folder icons
		switch(faction)
			if("Buildaborg Group")
				icon_state = "folder_blue
			if("Freemesons")
				icon_state = "folder_red
			if("Men in Grey")
				icon_state = "folder_white
			if("Aliuminati")
				icon_state = "folder_yellow*/

/obj/item/weapon/conspiracyintel/buildaborg
	faction = "Buildaborg Group"

/obj/item/weapon/conspiracyintel/freemesons
	faction = "Freemesons"

/obj/item/weapon/conspiracyintel/mig
	faction = "Men in Grey"

/obj/item/weapon/conspiracyintel/aliuminati
	faction = "Aliuminati"

/obj/item/weapon/conspiracyintel/random

/obj/item/weapon/conspiracyintel/random/New()

	faction = pick("Buildaborg Group","Freemesons","Men in Grey","Aliuminati")
	..()

/obj/item/device/inteluplink
	name		= "Laptop Computer"
	desc		= "A clamshell portable computer. It is closed."
	icon		= 'icons/obj/computer3.dmi'
	icon_state	=  "adv-laptop-closed"
	item_state	=  "laptop-inhand"
	pixel_x		= 2
	pixel_y		= -3
	w_class		= 3
	var/open = 0
	var/uploading = 0
	var/stored_crystals = 0
	var/faction = "You shouldn't see this" 		//which faction receives the uploaded file - so the teams can't upload their own intel, as num
	var/alliedf = "You shouldn't see this" 		//one of the other factions, whose intel is not currently needed, as num
	var/cached_progress = 0 					//persistent progress - if you stop uploading, you can resume it later if it's the same file
	var/progress = 0 							//temporary progress
	var/lastuploaded = -1 						//caches id of the last intel item

/obj/item/device/inteluplink/New(var/maker)
	..()
	if(maker)
		faction = maker

/obj/item/device/inteluplink/verb/open_computer()
	set name = "Open Laptop"
	set category = "Object"
	set src in view(1)

	if(open)
		return

	if(usr.stat || usr.restrained() || usr.lying || !istype(usr, /mob/living))
		usr << "<span class='warning'>You can't do that.</span>"
		return

	if(!Adjacent(usr))
		usr << "You can't reach it."
		return

	if(!istype(loc,/turf))
		usr << "[src] is too bulky!  You'll have to set it down."
		return

	usr << "You open \the [src]."
	open = 1
	update_icon()

/obj/item/device/inteluplink/verb/close_computer()
	set name = "Close Laptop"
	set category = "Object"
	set src in view(1)

	if(!open)
		return

	if(usr.stat || usr.restrained() || usr.lying || !istype(usr, /mob/living))
		usr << "<span class='warning'>You can't do that.</span>"
		return

	if(!Adjacent(usr))
		usr << "You can't reach it."
		return

	if(!istype(loc,/turf))
		usr << "[src] is too bulky!  You'll have to set it down."
		return

	usr << "You close \the [src]."
	open = 0
	update_icon()

/obj/item/device/inteluplink/update_icon()
	if(open)
		icon_state = "adv-laptop"
		overlays.Cut()
		if(uploading)
			var/global/image/screen = image('icons/obj/computer3.dmi',icon_state="osod")
			overlays = list(screen)
			desc = "A clamshell portable computer. It is open."
		else
			var/global/image/screen = image('icons/obj/computer3.dmi',icon_state="command")
			overlays = list(screen)
			desc = "A clamshell portable computer. It is open. It seems that some kind of files are being transmitted."
	else
		icon_state = "adv-laptop-closed"
		desc = "A clamshell portable computer. It is closed."

/obj/item/device/inteluplink/attackby(var/obj/item/I,mob/user as mob)
	if(!open)
		return
	if(istype(I,/obj/item/weapon/conspiracyintel))
		var/obj/item/weapon/conspiracyintel/C = I
		if(cmptext(C.faction,faction))
			user << "<span class='notice'>\The [C] you are trying to upload belongs to the faction you're trying to send it to.</span>"
			return
		if(cmptext(C.faction,alliedf))
			user << "<span class='notice'>\The [faction] does not need any more data on [C.faction].</span>"
			return
		if(!(C.upload_id))
			C.upload_id = rand(1,9999) //should be more than enough to be unique
		if(lastuploaded == C.upload_id)
			progress = cached_progress
		else
			progress = 0
		lastuploaded = C.upload_id
		uploading = 1
		update_icon()
		user.visible_message("<span class='notice'>[user] starts typing commands on \the [src]'s keyboard frantically!</span>","<span class='notice'>You start scanning and uploading \the [C] to the [faction]'s databases.</span>","<span class='notice'>You hear someone frantically typing on a keyboard.</span>")
		var/uploadamount = min(5,(100 - progress))
		while(do_after(user, 50, 5, 0))
			progress += uploadamount

			if(progress >= 100)
				user.visible_message("<span class='notice'>\The [src] buzzes and shreds the [C] as a progress bar reaches completion.</span>","<span class='notice'>\The [src] buzzes and shreds the [C] as a progress bar reaches completion.</span>","<span class='notice'>You hear a buzz and the sound of utterly annihilated paper.</span>")
				if(prob(50))
					alliedf = C.faction
					user << "<span class='notice'>A message from \the [faction] arrives: \"Thank you for your service. We will have no need for more data on [alliedf] for a while.\".</span>"
				uploading = 0
				progress = 0
				cached_progress = 0
				update_icon()

				var/obj/item/device/uplink/hidden/suplink = user.mind.find_syndicate_uplink()
				var/crystals
				crystals = C.value
				if (!isnull(crystals))
					if(suplink)
						suplink.uses += crystals
					else
						stored_crystals += crystals
				qdel(C)
		if(progress < 100)
			cached_progress = progress
			user << "<span class='warning'>\The [src] displays an error message: Upload halted at [cached_progress]%.</span>"

	if(stored_crystals)
		if(I.hidden_uplink)
			var/obj/item/device/uplink/hidden/suplink = I.hidden_uplink
			suplink.uses += stored_crystals
			stored_crystals = 0
	..()
