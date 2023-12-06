extends CharacterBody3D


const SPEED = 1.2
const JUMP_VELOCITY = 4.5
var direction
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var AnimTree = get_node("AnimationTree")
@onready var playback = AnimTree.get("parameters/playback")
@onready var player_mesh = get_node("Player")


@onready var test = $"../"
@onready var Door1floorMiddle = $"../NavigationRegion3D/p2/doorMiddle"
@onready var Door1floorRight = $"../NavigationRegion3D/p2/doorRight"
@onready var Door0floorMiddle = $"../NavigationRegion3D/p1/doorMiddle"
@onready var Door0floorRight = $"../NavigationRegion3D/p1/doorRight"
@onready var DoorExit = $"../NavigationRegion3D/p1/doorExit"
@onready var Meble = $"../NavigationRegion3D/Meble"


var FloorHeight = 2.5
var Floor0 = 0
var Floor1 = 2.5
var state
var state_factory
var ShiftLeft = -0.2
var ShiftRight = 0.2
var isOutside = true
var interactedWithMebel
var meble = []
var onFloor0 = true;
var spotted = false;


func _ready():
	state_factory = StateFactory.new()
	change_state("idle")
	get_furniture_meshes()
	fill_furnitures()
	interactedWithMebel = false


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var h_rot = $"../Camera3D".transform.basis.get_euler().y
	direction = Vector3(Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft"), 0, Input.get_action_strength("WalkBackward") - Input.get_action_strength("WalkForward"))
	direction = direction.rotated(Vector3.UP, h_rot).normalized()
	run_door_interaction()
	move_and_slide()
	check_interactions()
	
	
func change_state(new_state_name):
	if state != null:
		state.exit()
		state.queue_free()
		
	state = state_factory.get_state(new_state_name).new()
	state.setup("change_state", playback, self)
	state.name = new_state_name
	add_child(state)
	
		
func door_interaction(From, To, ActuallFloor, Floor, whichFloor):
	if ((self.position.x >= From.position.x - 1 and self.position.x <= From.position.x + 1)
	and (self.position.y > ActuallFloor and self.position.y < ActuallFloor + FloorHeight)
	and (self.position.z >= From.position.z - 1 and self.position.z <= From.position.z + 1)):
		self.position.x = To.position.x
		self.position.y = Floor
		self.position.z = To.position.z + 2
		self.rotation.y = 180	
		onFloor0 = whichFloor
		
		direction = direction.rotated(Vector3.UP, $"../Camera3D".transform.basis.get_euler().y + Floor).normalized()
		
	
func exitHouse(Door):
	if(isOutside):
		return
		
	if(self.position.x < Door.position.x - 1 and self.position.x > Door.position.x - 1.1
	and self.position.z > Door.position.z - 1 and self.position.z < Door.position.z + 1):
		self.position.x = Door.position.x + 1.11 #TO MUSI BYC WIEKSZE NIZ WARUNEK
		isOutside = true
		test.lost = false
		test.endGame = true


func enterHouse(Door):
	if(!isOutside):
		return
		#DRZWI SZEROKOSC 2px
	if(self.position.x > Door.position.x + 1 and self.position.x < Door.position.x + 1.1
	and self.position.z > Door.position.z - 1 and self.position.z < Door.position.z + 1):
		self.position.x = Door.position.x - 1.11
		isOutside = false


func run_door_interaction():
	door_interaction(Door0floorMiddle, Door1floorMiddle, Floor0, Floor1, false)
	door_interaction(Door1floorMiddle, Door0floorMiddle, Floor1, Floor0, true)
	door_interaction(Door1floorRight, Door0floorRight, Floor1, Floor0, true)
	door_interaction(Door0floorRight, Door1floorRight, Floor0, Floor1, false)
	enterHouse(DoorExit)
	exitHouse(DoorExit)
	
	
func get_furniture_meshes():
	var pokoje = Meble.get_children()
	for pokoj in pokoje:
		if pokoj is Node3D:
			var mebleWpokoju = pokoj.get_children()
			print(mebleWpokoju)
			for mebelMesh in mebleWpokoju:
				if mebelMesh is MeshInstance3D:
					var mebel = mebelMesh.get_children()
					for mebelStatic in mebel:
						if mebelStatic is StaticBody3D:
							var mebelArea = mebelStatic.get_children()
							for Area in mebelArea:
									if Area and Area is Area3D:
										print("\nArea for collision", Area)
										Area.add_to_group("interactable")
										meble.append(Area)
	
	
func check_interactions():
	for mebelArea in meble:
		if mebelArea.is_in_group("interactable") and mebelArea.overlaps_area(self.find_child("Area3D",false,true)):
			if not interactedWithMebel:
				print("Podszedłeś do mebla: ", mebelArea)
				interactedWithMebel = true
			else:
				interactedWithMebel = false
			
			if Input.is_action_pressed("Interact"):
				Inv.furnitureId = mebelArea.get_instance_id()
				$furnitureUI.fillContainer()
			# Tutaj możesz umieścić kod obsługi interakcji, np. podświetlenie mebla
			# highlight_mebel(mebelArea, true)


func fill_furnitures():
	for furniture in meble:
		var id = furniture.get_instance_id()
		var items = {}
		for i in range(2):
			var randNumber = randi() % 20
			items[i] = Inv.items[randNumber]
			
		Inv.furnitureItem[id] = items
