extends CharacterBody3D

var SPEED = 1.4
const JUMP_VELOCITY = 4.5
var destination = Vector3(0, 0, 0)
var fieldOfView = 90.0  # Kąt widzenia w stopniach
var viewDistance = 10.0  # Maksymalna odległość widzenia

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var test = $"../"
@onready var player = $"../Player"
@onready var nav = $NavigationAgent3D
@onready var markers = $"../Markers"

@onready var Door1floorMiddle = $"../NavigationRegion3D/p2/doorMiddle"
@onready var Door1floorRight = $"../NavigationRegion3D/p2/doorRight"
@onready var Door0floorMiddle = $"../NavigationRegion3D/p1/doorMiddle"
@onready var Door0floorRight = $"../NavigationRegion3D/p1/doorRight"

var FloorHeight = 2.5
var Floor0 = 0
var Floor1 = 2.5
var whereToGo = 0;

var state
var state_factory

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var direction = Vector3()
	#checkFieldOfView()
	if player.spotted == false:
		if whereToGo == 0:
			nav.target_position = markers.get_child(0).global_position
			self.get_position_delta()
			if self.position.x - markers.get_child(0).global_position.x < 0.3 && self.position.x - markers.get_child(0).global_position.x > -0.3 && self.position.y - markers.get_child(0).global_position.y < 0.3 && self.position.y - markers.get_child(0).global_position.y > -0.3 && self.position.z - markers.get_child(0).global_position.z < 0.3 && self.position.z - markers.get_child(0).global_position.z > -0.3:
				whereToGo = 1
		elif whereToGo == 1:
			nav.target_position = markers.get_child(1).global_position
			self.get_position_delta()
		elif whereToGo == 2:
			print (self.position)
			nav.target_position = markers.get_child(2).global_position
			self.get_position_delta()
			if self.position.x - markers.get_child(2).global_position.x < 0.3 && self.position.x - markers.get_child(2).global_position.x > -0.3 && self.position.y - markers.get_child(2).global_position.y < 0.3 && self.position.y - markers.get_child(2).global_position.y > -0.3 && self.position.z - markers.get_child(2).global_position.z < 0.3 && self.position.z - markers.get_child(2).global_position.z > -0.3:
				whereToGo = 3
		elif whereToGo == 3:
			nav.target_position = markers.get_child(3).global_position
			self.get_position_delta()
	else:
		SPEED = 2.8
		nav.target_position = player.global_position
	direction = nav.get_next_path_position() - global_position
	run_door_interaction()
	
	velocity = velocity.lerp(direction*SPEED, SPEED*delta)
	if velocity.x != 0 || velocity.z != 0 :
		if player.spotted == false:
			get_node("NPC1Anim/AnimationPlayer").play("NPC1Walking")
		else:
			get_node("NPC1Anim/AnimationPlayer").play("NPC1Running")
	else:
		get_node("NPC1Anim/AnimationPlayer").play("NPC1Idle")
	look_at(Vector3(nav.target_position))
	for collision_index in get_slide_collision_count():
		var collision = get_slide_collision(collision_index)
		if collision.get_collider() is CharacterBody3D and "NPCs" not in collision.get_collider():
			test.lost = true
			test.endGame = true;
	move_and_slide()

func door_interaction(From, To, ActuallFloor, Floor, marker):
	if ((self.position.x >= From.position.x - 1 and self.position.x <= From.position.x + 1)
	and (self.position.y > ActuallFloor and self.position.y < ActuallFloor + FloorHeight)
	and (self.position.z >= From.position.z - 1 and self.position.z <= From.position.z + 1)):
		self.position.x = To.position.x
		self.position.y = Floor
		print("Wchodzę")
		self.position.z = To.position.z + 2
		print("Wychodzę")
		whereToGo = marker

func run_door_interaction():
	door_interaction(Door0floorMiddle, Door1floorMiddle, Floor0, Floor1, 2)
	door_interaction(Door1floorMiddle, Door0floorMiddle, Floor1, Floor0, 0)
	door_interaction(Door1floorRight, Door0floorRight, Floor1, Floor0, 0)
	door_interaction(Door0floorRight, Door1floorRight, Floor0, Floor1, 0)

#func checkFieldOfView():
	#var objects = get_overlapping_bodies()
	#for obj in objects:
		#if obj is CharacterBody3D and obj != self:
			# Sprawdź, czy obiekt jest w zasięgu widzenia
			#var direction_to_object = (obj.global_transform.origin - global_transform.origin).normalized()
			#var angle_to_object = direction_to_object.angle_to(global_transform.basis.xform(Vector3(0, 0, 1)).normalized())

			#if angle_to_object <= deg2rad(fieldOfView / 2) and direction_to_object.length() <= viewDistance:
				# Jeśli obiekt jest w zasięgu widzenia, możesz podjąć odpowiednie działania
				#print("Znaleziono obiekt w zasięgu widzenia: ", obj.name)
