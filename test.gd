extends Node3D

@onready var game_menu = $gameMenu
var paused = false

func _ready():
	if GlobalScript.retToMainMenu == true:
		game_menu.show()
		Engine.time_scale = 0
		paused = !paused

func _process(delta):
	if Input.is_action_just_pressed("MenuGame"):
		pauseMenu()

func pauseMenu():
	if paused:
		game_menu.hide()
		Engine.time_scale = 1
	else:
		game_menu.show()
		Engine.time_scale = 0
	paused = !paused
