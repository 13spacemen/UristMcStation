// Holographic Items!

// Holographic tables are in code/modules/tables/presets.dm
// Holographic racks are in code/modules/tables/rack.dm

/turf/simulated/floor/holofloor
	thermal_conductivity = 0

// the new Diona Death Prevention Feature: gives an average amount of lumination
/turf/simulated/floor/holofloor/get_lumcount(var/minlum = 0, var/maxlum = 1)
	return 0.8

/turf/simulated/floor/holofloor/attackby(obj/item/weapon/W as obj, mob/user as mob)
	return
	// HOLOFLOOR DOES NOT GIVE A FUCK

/turf/simulated/floor/holofloor/set_flooring()
	return

/turf/simulated/floor/holofloor/carpet
	name = "brown carpet"
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_state = "brown"
	initial_flooring = /decl/flooring/carpet

/turf/simulated/floor/holofloor/concrete
	name = "brown carpet"
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_state = "brown"
	initial_flooring = /decl/flooring/carpet

/turf/simulated/floor/holofloor/concrete
	name = "floor"
	icon = 'icons/turf/flooring/misc.dmi'
	icon_state = "concrete"
	initial_flooring = null

/turf/simulated/floor/holofloor/tiled
	name = "floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "steel"
	initial_flooring = /decl/flooring/tiling

/turf/simulated/floor/holofloor/tiled/dark
	name = "dark floor"
	icon_state = "dark"
	initial_flooring = /decl/flooring/tiling/dark

/turf/simulated/floor/holofloor/tiled/old_tile
	name = "floor"
	icon_state = "tile_full"
	initial_flooring = /decl/flooring/tiling/new_tile

/turf/simulated/floor/holofloor/tiled/stone
	name = "stone floor"
	icon_state = "stone"
	initial_flooring = /decl/flooring/tiling/stone

/turf/simulated/floor/holofloor/tiled/white
	name = "white floor"
	icon_state = "white"
	initial_flooring = /decl/flooring/tiling/white

/turf/simulated/floor/holofloor/lino
	name = "lino"
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_state = "lino"
	initial_flooring = /decl/flooring/linoleum

/turf/simulated/floor/holofloor/wood
	name = "wooden floor"
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "walnut"
	initial_flooring = /decl/flooring/wood

/turf/simulated/floor/holofloor/grass
	name = "lush grass"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_state = "grass0"
	initial_flooring = /decl/flooring/grass

/turf/simulated/floor/holofloor/snow
	name = "snow"
	base_name = "snow"
	icon = 'icons/turf/floors.dmi'
	base_icon = 'icons/turf/floors.dmi'
	icon_state = "snow"
	base_icon_state = "snow"

/turf/simulated/floor/holofloor/space
	icon = 'icons/turf/space.dmi'
	name = "\proper space"
	icon_state = "0"

/turf/simulated/floor/holofloor/reinforced
	icon = 'icons/turf/flooring/tiles.dmi'
	initial_flooring = /decl/flooring/reinforced
	name = "reinforced holofloor"
	icon_state = "reinforced"

/turf/simulated/floor/holofloor/space/New()
	icon_state = "[((x + y) ^ ~(x * y) + z) % 25]"

/turf/simulated/floor/holofloor/beach
	desc = "Uncomfortably gritty for a hologram."
	base_desc = "Uncomfortably gritty for a hologram."
	icon = 'icons/misc/beach.dmi'
	base_icon = 'icons/misc/beach.dmi'
	initial_flooring = null

/turf/simulated/floor/holofloor/beach/sand
	name = "sand"
	icon_state = "desert0"
	base_icon_state = "desert0"

/turf/simulated/floor/holofloor/beach/coastline
	name = "coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"
	base_icon_state = "sandwater"

/turf/simulated/floor/holofloor/beach/water
	name = "water"
	icon_state = "seashallow"
	base_icon_state = "seashallow"

/turf/simulated/floor/holofloor/desert
	name = "desert sand"
	base_name = "desert sand"
	desc = "Uncomfortably gritty for a hologram."
	base_desc = "Uncomfortably gritty for a hologram."
	icon_state = "desert6"
	base_icon_state = "desert6"
	initial_flooring = null
	icon = 'icons/turf/desert.dmi'
	base_icon = 'icons/turf/desert.dmi'

/turf/simulated/floor/holofloor/path
	name = "sand path"
	base_name = "sand path"
	desc = "Uncomfortably gritty for a hologram."
	base_desc = "Uncomfortably gritty for a hologram."
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	icon = 'icons/turf/flooring/asteroid.dmi'
	base_icon = 'icons/turf/flooring/asteroid.dmi'
	initial_flooring = null

/turf/simulated/floor/holofloor/desert/New()
	..()
	if(prob(10))
		overlays += "asteroid[rand(0,9)]"

/obj/structure/holostool
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/furniture.dmi'
	icon_state = "stool_padded_preview"
	anchored = 1.0

/obj/item/clothing/gloves/boxing/hologlove
	name = "boxing gloves"
	desc = "Because you really needed another excuse to punch your crewmates."
	icon_state = "boxing"
	item_state = "boxing"

/obj/structure/window/holowindow/full
	dir = 5
	icon_state = "window_full"

/obj/structure/window/holowindow/full/Destroy()
	..()

/obj/structure/window/reinforced/holowindow/Destroy()
	..()

/obj/structure/window/reinforced/holowindow/attackby(obj/item/W as obj, mob/user as mob)

	if(!istype(W) || W.item_flags & ITEM_FLAG_NO_BLUDGEON) return

	if(isScrewdriver(W) || isCrowbar(W) || isWrench(W))
		to_chat(user, ("<span class='notice'>It's a holowindow, you can't dismantle it!</span>"))
	else
		if(W.damtype == BRUTE || W.damtype == BURN)
			hit(W.force)
			if(health <= 7)
				anchored = 0
				update_nearby_icons()
				step(src, get_dir(user, src))
		else
			playsound(loc, 'sound/effects/Glasshit.ogg', 75, 1)
		..()
	return

/obj/structure/window/reinforced/holowindow/shatter(var/display_message = 1)
	playsound(src, "shatter", 70, 1)
	if(display_message)
		visible_message("[src] fades away as it shatters!")
	qdel(src)
	return

/obj/structure/window/reinforced/holowindow/disappearing/Destroy()
	..()

/obj/machinery/door/window/holowindoor/Destroy()
	..()

/obj/machinery/door/window/holowindoor/attackby(obj/item/weapon/I as obj, mob/user as mob)

	if (src.operating == 1)
		return

	if(src.density && istype(I, /obj/item/weapon) && !istype(I, /obj/item/weapon/card))
		var/aforce = I.force
		playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
		visible_message("<span class='danger'>\The [src] was hit by \the [I].</span>")
		if(I.damtype == BRUTE || I.damtype == BURN)
			take_damage(aforce)
		return

	src.add_fingerprint(user)
	if (!src.requiresID())
		user = null

	if (src.allowed(user))
		if (src.density)
			open()
		else
			close()

	else if (src.density)
		flick(text("[]deny", src.base_state), src)

	return

/obj/machinery/door/window/holowindoor/shatter(var/display_message = 1)
	src.set_density(0)
	playsound(src, "shatter", 70, 1)
	if(display_message)
		visible_message("[src] fades away as it shatters!")
	qdel(src)

/obj/structure/bed/chair/holochair/Destroy()
	..()

/obj/structure/bed/chair/holochair/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		to_chat(user, ("<span class='notice'>It's a holochair, you can't dismantle it!</span>"))
	return

/obj/structure/bed/chair/holochair/wood
	name = "classic chair"
	desc = "Old is never too old to not be in fashion."
	base_icon = "wooden_chair"
	icon_state = "wooden_chair_preview"

/obj/structure/bed/chair/holochair/wood/New(var/newloc)
	..(newloc, MATERIAL_WOOD)

/obj/item/weapon/holo
	damtype = PAIN
	no_attack_log = 1

/obj/item/weapon/holo/esword
	name = "holosword"
	desc = "May the force be within you. Sorta."
	icon_state = "sword0"
	force = 3.0
	throw_speed = 1
	throw_range = 5
	throwforce = 0
	w_class = ITEM_SIZE_SMALL
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_NO_BLOOD
	base_parry_chance = 50
	var/active = 0
	var/blade_color

/obj/item/weapon/holo/esword/green
	New()
		blade_color = "green"

/obj/item/weapon/holo/esword/red
	New()
		blade_color = "red"

/obj/item/weapon/holo/esword/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	. = ..()
	if(.)
		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, user.loc)
		spark_system.start()
		playsound(user.loc, 'sound/weapons/blade1.ogg', 50, 1)

/obj/item/weapon/holo/esword/get_parry_chance(mob/user)
	return active ? ..() : 0

/obj/item/weapon/holo/esword/New()
	blade_color = pick("red","blue","green","purple")

/obj/item/weapon/holo/esword/attack_self(mob/living/user as mob)
	active = !active
	if (active)
		force = 30
		icon_state = "sword[blade_color]"
		w_class = ITEM_SIZE_HUGE
		playsound(user, 'sound/weapons/saberon.ogg', 50, 1)
		to_chat(user, "<span class='notice'>[src] is now active.</span>")
	else
		force = 3
		icon_state = "sword0"
		w_class = ITEM_SIZE_SMALL
		playsound(user, 'sound/weapons/saberoff.ogg', 50, 1)
		to_chat(user, "<span class='notice'>[src] can now be concealed.</span>")

	update_held_icon()

	add_fingerprint(user)
	return

//BASKETBALL OBJECTS

/obj/item/weapon/beach_ball/holoball
	icon = 'icons/obj/basketball.dmi'
	icon_state = "basketball"
	name = "basketball"
	item_state = "basketball"
	desc = "Here's your chance, do your dance at the Space Jam."
	w_class = ITEM_SIZE_LARGE //Stops people from hiding it in their pockets

/obj/structure/holohoop
	name = "basketball hoop"
	desc = "Boom, Shakalaka!"
	icon = 'icons/obj/basketball.dmi'
	icon_state = "hoop"
	anchored = 1
	density = 1
	throwpass = 1

/obj/structure/holohoop/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(istype(I, /obj/item/projectile))
			return
		if(prob(50))
			I.dropInto(loc)
			visible_message("<span class='notice'>Swish! \the [I] lands in \the [src].</span>", 3)
		else
			visible_message("<span class='warning'>\The [I] bounces off of \the [src]'s rim!</span>", 3)
		return 0
	else
		return ..(mover, target, height, air_group)

//VOLEYBALL OBJECTS

/obj/item/weapon/beach_ball/holovolleyball
	icon = 'icons/obj/basketball.dmi'
	icon_state = "volleyball"
	name = "voleyball"
	item_state = "volleyball"
	desc = "You can be my wingman anytime."
	w_class = ITEM_SIZE_LARGE //Stops people from hiding it in their pockets

/obj/structure/holonet
	name = "net"
	desc = "Bullshit, you can be mine!"
	icon = 'icons/obj/basketball.dmi'
	icon_state = "volleynet_mid"
	density = 1
	anchored = 1
	layer = TABLE_LAYER
	throwpass = 1
	dir = 4

/obj/structure/holonet/end
	icon_state = "volleynet_end"

/obj/structure/holonet/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(istype(I, /obj/item/projectile))
			return
		if(prob(10))
			I.dropInto(loc)
			visible_message("<span class='notice'>Swish! \the [I] gets caught in \the [src].</span>", 3)
			return 0
		else
			return 1
	else
		return ..(mover, target, height, air_group)

/obj/machinery/readybutton
	name = "Ready Declaration Device"
	desc = "This device is used to declare ready. If all devices in an area are ready, the event will begin!"
	icon = 'icons/obj/monitors.dmi'
	icon_state = "auth_off"
	var/ready = 0
	var/area/currentarea = null
	var/eventstarted = 0

	anchored = 1.0
	idle_power_usage = 2
	active_power_usage = 6
	power_channel = ENVIRON

/obj/machinery/readybutton/attack_ai(mob/user as mob)
	to_chat(user, "The AI is not to interact with these devices!")
	return

/obj/machinery/readybutton/New()
	..()


/obj/machinery/readybutton/attackby(obj/item/weapon/W as obj, mob/user as mob)
	to_chat(user, "The device is a solid button, there's nothing you can do with it!")

/obj/machinery/readybutton/attack_hand(mob/user as mob)

	if(user.stat || stat & (NOPOWER|BROKEN))
		to_chat(user, "This device is not powered.")
		return

	if(!user.IsAdvancedToolUser())
		return 0

	currentarea = get_area(src.loc)
	if(!currentarea)
		qdel(src)

	if(eventstarted)
		to_chat(usr, "The event has already begun!")
		return

	ready = !ready

	update_icon()

	var/numbuttons = 0
	var/numready = 0
	for(var/obj/machinery/readybutton/button in currentarea)
		numbuttons++
		if (button.ready)
			numready++

	if(numbuttons == numready)
		begin_event()

/obj/machinery/readybutton/on_update_icon()
	if(ready)
		icon_state = "auth_on"
	else
		icon_state = "auth_off"

/obj/machinery/readybutton/proc/begin_event()

	eventstarted = 1

	for(var/obj/structure/window/reinforced/holowindow/disappearing/W in currentarea)
		qdel(W)

	for(var/mob/M in currentarea)
		to_chat(M, "FIGHT!")

//Holocarp

/mob/living/simple_animal/hostile/carp/holodeck
	icon = 'icons/mob/hologram.dmi'
	icon_state = "Carp"
	icon_living = "Carp"
	icon_dead = "Carp"
	alpha = 127
	icon_gib = null
	meat_amount = 0
	meat_type = null

/mob/living/simple_animal/hostile/carp/holodeck/carp_randomify()
	return

/mob/living/simple_animal/hostile/carp/holodeck/on_update_icon()
	return

/mob/living/simple_animal/hostile/carp/holodeck/New()
	..()
	set_light(0.5, 0.1, 2) //hologram lighting

/mob/living/simple_animal/hostile/carp/holodeck/proc/set_safety(var/safe)
	if (safe)
		faction = MOB_FACTION_NEUTRAL
		melee_damage_lower = 0
		melee_damage_upper = 0
		environment_smash = 0
		environment_smash = 0
	else
		faction = "carp"
		melee_damage_lower = initial(melee_damage_lower)
		melee_damage_upper = initial(melee_damage_upper)
		environment_smash = initial(environment_smash)
		environment_smash = initial(environment_smash)

/mob/living/simple_animal/hostile/carp/holodeck/gib()
	death()

/mob/living/simple_animal/hostile/carp/holodeck/death()
	..(null, "fades away!", "You have been destroyed.")
	qdel(src)

//fitness

/obj/structure/fitness/weightlifter/holo/attackby(obj/item/weapon/W as obj, mob/user as mob)
	return
