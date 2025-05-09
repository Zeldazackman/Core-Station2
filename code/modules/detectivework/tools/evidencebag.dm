//CONTAINS: Evidence bags and fingerprint cards

/obj/item/evidencebag
	name = "evidence bag"
	desc = "An empty evidence bag.  Use by clicking on the bag and dragging it to the item you want to bag."
	icon = 'icons/obj/storage.dmi'
	icon_state = "evidenceobj"
	item_state = null
	w_class = ITEMSIZE_SMALL
	var/obj/item/stored_item = null

/obj/item/evidencebag/MouseDrop(var/obj/item/I)
	if (!ishuman(usr))
		return
	if(!istype(I) || I.anchored)
		return  ..()

	var/mob/living/carbon/human/user = usr

	if(!user.item_is_in_hands(src))
		return //bag must be in your hands to use

	if (isturf(I.loc))
		if (!user.Adjacent(I))
			return
	else
		//If it isn't on the floor. Do some checks to see if it's in our hands or a box. Otherwise give up.
		if(istype(I.loc,/obj/item/storage))	//in a container.
			var/sdepth = I.storage_depth(user)
			if (sdepth > MAX_STORAGE_REACH)
				return	//too deeply nested to access

			var/obj/item/storage/U = I.loc
			user.client.screen -= I
			U.contents.Remove(I)
		else if(user.item_is_in_hands(I))
			user.drop_from_inventory(I)
		else
			return

	if(istype(I, /obj/item/evidencebag))
		to_chat(user, span_notice("You find putting an evidence bag in another evidence bag to be slightly absurd."))
		return

	if(I.w_class > 3)
		to_chat(user, span_notice("[I] won't fit in [src]."))
		return

	if(contents.len)
		to_chat(user, span_notice("[src] already has something inside it."))
		return

	user.visible_message("[user] puts [I] into [src]", "You put [I] inside [src].",\
	"You hear a rustle as someone puts something into a plastic bag.")

	icon_state = "evidence"

	var/xx = I.pixel_x	//save the offset of the item
	var/yy = I.pixel_y
	I.pixel_x = 0		//then remove it so it'll stay within the evidence bag
	I.pixel_y = 0
	var/image/img = image("icon"=I, "layer"=FLOAT_LAYER)	//take a snapshot. (necessary to stop the underlays appearing under our inventory-HUD slots ~Carn
	I.pixel_x = xx		//and then return it
	I.pixel_y = yy
	add_overlay(img)
	add_overlay("evidence")	//should look nicer for transparent stuff. not really that important, but hey.

	desc = "An evidence bag containing [I]."
	I.loc = src
	stored_item = I
	w_class = I.w_class
	return


/obj/item/evidencebag/attack_self(mob/user as mob)
	if(contents.len)
		var/obj/item/I = contents[1]
		user.visible_message("[user] takes [I] out of [src]", "You take [I] out of [src].",\
		"You hear someone rustle around in a plastic bag, and remove something.")
		cut_overlays()	//remove the overlays

		user.put_in_hands(I)
		stored_item = null

		w_class = initial(w_class)
		icon_state = "evidenceobj"
		desc = "An empty evidence bag."
	else
		to_chat(user, "[src] is empty.")
		icon_state = "evidenceobj"
	return

/obj/item/evidencebag/examine(mob/user)
	. = ..()
	if(stored_item)
		user.examinate(stored_item)
