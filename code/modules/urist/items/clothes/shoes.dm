 /*										*****New space to put all UristMcStation Shoes and Boots!*****

Please keep it tidy, by which I mean put comments describing the item before the entry. Icons go to 'icons/urist/items/clothes/shoes.dmi' and on- mob
icon_override sprites go to 'icons/uristmob/shoes.dmi' Items should go to clothing/shoes/urist to avoid worrying about the sprites -Glloyd*/

//generic define

/obj/item/clothing/shoes/urist
	urist_only = 1
	icon_override = 'icons/uristmob/shoes.dmi'
	icon = 'icons/urist/items/clothes/shoes.dmi'

//obviously the guy who made the equipment for engineers never worked a blue collar job in his life. The engineers
//ingame wouldn't even be allowed on a modern constuction site without steel toed boots, let alone allowed to work on one.

/obj/item/clothing/shoes/urist/leather //not OP. Corai said so ;)
	desc = "A pair of steel toed leather work boots. They are quite heavy, but protect your feet from most brute damage and have a thin metal strip in the sole to protect against nails. The rubber bottoms protect against slipping."
	name = "leather boots"
	icon_state = "leather"
	permeability_coefficient = 0.05
	flags = NOSLIP
	slowdown = SHOES_SLOWDOWN+1
	species_restricted = null
	siemens_coefficient = 0.6
	armor = list(melee = 50, bullet = 0, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)

	cold_protection = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE