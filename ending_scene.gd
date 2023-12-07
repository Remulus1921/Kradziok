extends Control

func _ready():
	pass # Replace with function body.

func _on_next_game_button_pressed():
	Engine.time_scale = 1
	Inv.inventory = {}
	get_tree().reload_current_scene()

func _on_quit_to_the_menu_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://main_menu.tscn")
