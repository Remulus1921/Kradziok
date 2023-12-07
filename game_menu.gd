extends Control

@onready var test = $"../"
@onready var menu := $MarginContainer/VBoxContainer
@onready var settings := $Settings
@onready var musicSlider := $Settings/MarginContainer/VBoxContainer/MusicSlider
@onready var soundSlider := $Settings/MarginContainer/VBoxContainer/SoundSlider

func _ready():
	volume(1, linear_to_db(musicSlider.value));
	if GlobalScript.retToMainMenu == true:
		menu.visible = false;
		settings.visible = true;

func _on_return_to_game_button_pressed():
	test.pauseMenu()

func _on_exit_to_the_menu_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_game_settings_button_pressed():
	menu.visible = false;
	settings.visible = true;

func _on_return_button_pressed():
	if GlobalScript.retToMainMenu == true:
		test.paused = !test.paused
		Engine.time_scale = 1
		settings.visible = false;
		menu.visible = false;
		get_tree().change_scene_to_file("res://main_menu.tscn")
	else:
		settings.visible = false;
		menu.visible = true;

func _on_music_button_toggled(button_pressed):
	if button_pressed == true:
		musicSlider.editable = true;
	else:
		musicSlider.editable = false;
		musicSlider.value = 0;

func _on_full_screen_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value);

func _on_music_slider_value_changed(value):
	volume(1, linear_to_db(value));	
