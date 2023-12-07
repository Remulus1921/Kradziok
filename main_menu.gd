extends Control

@onready var menu := $MarginContainer/Menu
@onready var settings := $Settings

func _on_new_game_button_pressed():
	GlobalScript.retToMainMenu = false;
	Inv.inventory = {}
	get_tree().change_scene_to_file("res://test.tscn")

func _on_settings_button_pressed():
	GlobalScript.retToMainMenu = true;
	get_tree().change_scene_to_file("res://test.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

