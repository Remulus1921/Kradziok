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

var FloorHeight = 2.5
var Floor0 = 0
var Floor1 = 2.5
var whereToGo = 0;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	var direction = Vector3()
	#checkFieldOfView()
	if player.spotted == false:
		if whereToGo == 0:
			nav.target_position = Vector3( self.position.x, self.position.y, -2)
			self.get_position_delta()
			if self.position == nav.target_position:
				whereToGo = 1
		elif whereToGo == 1:
			nav.target_position = Vector3( self.position.x, self.position.y, 2)
			self.get_position_delta()
			if self.position == nav.target_position:
				whereToGo = 0
	else:
		SPEED = 1.0
		nav.target_position = player.global_position
	direction = nav.get_next_path_position() - global_position
	
	velocity = velocity.lerp(direction*SPEED, SPEED*delta)
	
	for collision_index in get_slide_collision_count():
		var collision = get_slide_collision(collision_index)
		if collision.get_collider() is CharacterBody3D and "NPCs" not in collision.get_collider():
			test.lost = true
			test.endGame = true;
	move_and_slide()

func set_random_destination():
	# Ustawienie losowego celu na mapie terenu
	destination = Vector3(randf_range(-10, 10), randf_range(0, 0), randf_range(-10, 10))

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
