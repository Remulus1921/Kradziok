extends Control

@onready var menu := $MarginContainer/Menu
@onready var settings := $Settings
#@onready var musicSlider := $Settings/MarginContainer/VBoxContainer/MusicSlider
#@onready var soundSlider := $Settings/MarginContainer/VBoxContainer/SoundSlider

#func _ready():
#	volume(1, linear_to_db(musicSlider.value));

func _on_new_game_button_pressed():
	GlobalScript.retToMainMenu = false;
	get_tree().change_scene_to_file("res://test.tscn")

func _on_settings_button_pressed():
	GlobalScript.retToMainMenu = true;
	get_tree().change_scene_to_file("res://test.tscn")

#func _on_return_button_pressed():
#	settings.visible = false;
#	menu.visible = true;

func _on_quit_button_pressed():
	get_tree().quit()

#func _on_music_enable_toggled(button_pressed):
#	if button_pressed == true:
#		musicSlider.editable = true;
#	else:
#		musicSlider.editable = false;
#		musicSlider.value = 0;

#func _on_sound_enable_toggled(button_pressed):
#	if button_pressed == true:
#		soundSlider.editable = true;
#	else:
#		soundSlider.editable = false;
#		soundSlider.value = 0;

#func volume(bus_index, value):
#	AudioServer.set_bus_volume_db(bus_index, value);

#func _on_music_slider_value_changed(value):
#	volume(1, linear_to_db(value));	

#func _on_sound_slider_value_changed(value):
#	volume(2, value);

#func _on_full_screen_enable_toggled(button_pressed):
#	if button_pressed == true:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
#	else:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
