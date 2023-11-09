extends CharacterBody3D


const SPEED = 0.75
const JUMP_VELOCITY = 4.5
var direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var AnimTree = get_node("AnimationTree")
@onready var playback = AnimTree.get("parameters/playback")
@onready var player_mesh = get_node("Player")

var state
var state_factory

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var h_rot = $"../Camera3D".transform.basis.get_euler().y
	direction = Vector3(Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft"), 0, Input.get_action_strength("WalkBackward") - Input.get_action_strength("WalkForward"))
	direction = direction.rotated(Vector3.UP, h_rot).normalized()
	
	move_and_slide()
	
func change_state(new_state_name):
	if state != null:
		state.exit()
		state.queue_free()
		
	#Add new state
	state = state_factory.get_state(new_state_name).new()
	state.setup("change_state", playback, self)
	state.name = new_state_name
	
	add_child(state)
