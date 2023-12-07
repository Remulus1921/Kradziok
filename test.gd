extends Node3D

@onready var game_menu = $gameMenu
@onready var player = $Player
@onready var ending_scene = $ending_scene
@onready var lost_scene = $lost_scene
var paused = false
var endGame = false
var lost = false

func _ready():
	if GlobalScript.retToMainMenu == true:
		game_menu.show()
		Engine.time_scale = 0
		paused = !paused

func _process(delta):
	if Input.is_action_just_pressed("MenuGame"):
		pauseMenu()
	endingGame()

func pauseMenu():
	if paused:
		game_menu.hide()
		Engine.time_scale = 1
	else:
		game_menu.show()
		Engine.time_scale = 0
	paused = !paused


func endingGame():
	if endGame == true:
		if lost == true:
			lost_scene.show()
			Engine.time_scale = 0
		else:
			if Inv.endGame == 0:
				ending_scene.fillList()
				Inv.endGame = 1
			ending_scene.show()
			Engine.time_scale = 0

func _physics_process(delta):
	get_tree().call_group("NPCs", "update_target_location", player.global_transform.origin)
