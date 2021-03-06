/obj/machinery/bluespace_beacon

	icon = 'icons/obj/objects.dmi'
	icon_state = "floor_beaconf"
	name = "Bluespace Gigabeacon"
	desc = "A device that draws power from bluespace and creates a permanent tracking beacon."
	level = 1		// underfloor
	anchored = 1
	idle_power_usage = 0
	var/obj/item/radio/beacon/Beacon

/obj/machinery/bluespace_beacon/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	Beacon = new /obj/item/radio/beacon(T)
	Beacon.invisibility = INVISIBILITY_MAXIMUM

	hide(!T.is_plating())

/obj/machinery/bluespace_beacon/Destroy()
	QDEL_NULL(Beacon)
	. = ..()

	// update the invisibility and icon
/obj/machinery/bluespace_beacon/hide(var/intact)
	set_invisibility(intact ? 101 : 0)
	update_icon()

	// update the icon_state
/obj/machinery/bluespace_beacon/on_update_icon()
	var/state="floor_beacon"

	if(invisibility)
		icon_state = "[state]f"

	else
		icon_state = "[state]"

/obj/machinery/bluespace_beacon/Process()
	if(!Beacon)
		Beacon = new /obj/item/radio/beacon(get_turf(src))
		Beacon.set_invisibility(INVISIBILITY_MAXIMUM)
	if(Beacon)
		if(Beacon.loc != loc)
			Beacon.forceMove(loc)

	update_icon()