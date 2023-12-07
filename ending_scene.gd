extends Control

func _ready():
	pass

func _on_next_game_button_pressed():
	Engine.time_scale = 1
	Inv.inventory = {}
	get_tree().reload_current_scene()

func _on_quit_to_the_menu_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://main_menu.tscn")

func fillList():
	var itemsValue = 0;	
	for i in Inv.inventory:
		$MarginContainer/ItemList.add_item(Inv.inventory[i]["Name"])
		$MarginContainer/ItemList.add_item(str(Inv.inventory[i]["Cost"]) + "$")
		itemsValue += Inv.inventory[i]["Cost"]
	if itemsValue > 0:
		$Label.text = "Wyniosłeś: " + str(itemsValue) + "$"
	else:
		$Label.text = "Coś cienko ci poszło albo masz za dobre serce. Ale Dlaczego nic nie wyniosłeś!?"
