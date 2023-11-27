extends CharacterBody3D


const SPEED = 1.2
const JUMP_VELOCITY = 4.5
var direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var AnimTree = get_node("AnimationTree")
@onready var playback = AnimTree.get("parameters/playback")
@onready var player_mesh = get_node("Player")

@onready var Door1floorMiddle = $"../NavigationRegion3D/p2/doorMiddle"
@onready var Door1floorRight = $"../NavigationRegion3D/p2/doorRight"
@onready var Door0floorMiddle = $"../NavigationRegion3D/p1/doorMiddle"
@onready var Door0floorRight = $"../NavigationRegion3D/p1/doorRight"
@onready var DoorExit = $"../NavigationRegion3D/p1/doorExit"


var FloorHeight = 2.5
var Floor0 = 0
var Floor1 = 2.5
var state
var state_factory
var ShiftLeft = -0.2
var ShiftRight = 0.2
var isOutside = true
var spotted = true

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
	run_door_interaction()
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
	
		
func door_interaction(From, To, ActuallFloor, Floor):
	if ((self.position.x >= From.position.x - 1 and self.position.x <= From.position.x + 1)
	and (self.position.y > ActuallFloor and self.position.y < ActuallFloor + FloorHeight)
	and (self.position.z >= From.position.z - 1 and self.position.z <= From.position.z + 1)):
		self.position.x = To.position.x
		self.position.y = Floor
		self.position.z = To.position.z + 2
		self.rotation.y = 180	
		
func exitHouse(Door):
	if(isOutside):
		return
		
	if(self.position.x < Door.position.x - 1 and self.position.x > Door.position.x - 1.1):
		self.position.x = Door.position.x + 1.11 #TO MUSI BYC WIEKSZE NIZ WARUNEK
		isOutside = true
		
func enterHouse(Door):
	if(!isOutside):
		return
		#DRZWI SZEROKOSC 2px
	if(self.position.x > Door.position.x + 1 and self.position.x < Door.position.x + 1.1):
		self.position.x = Door.position.x - 1.11
		isOutside = false

func run_door_interaction():
	door_interaction(Door0floorMiddle, Door1floorMiddle, Floor0, Floor1)
	door_interaction(Door1floorMiddle, Door0floorMiddle, Floor1, Floor0)
	door_interaction(Door1floorRight, Door0floorRight, Floor1, Floor0)
	door_interaction(Door0floorRight, Door1floorRight, Floor0, Floor1)
	enterHouse(DoorExit)
	exitHouse(DoorExit)
