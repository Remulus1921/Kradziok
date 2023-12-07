extends CharacterBody3D

var SPEED = 1.4
const JUMP_VELOCITY = 4.5
var destination = Vector3(0, 0, 0)

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
var onFloor0 = true;

var state
var state_factory

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var direction = Vector3()
	if player.spotted == false:
		if whereToGo == 0:
			nav.target_position = markers.get_child(0).global_position
			self.get_position_delta()
			if self.position.x - markers.get_child(0).global_position.x < 0.3 && self.position.x - markers.get_child(0).global_position.x > -0.3 && self.position.y - markers.get_child(0).global_position.y < 0.3 && self.position.y - markers.get_child(0).global_position.y > -0.3 && self.position.z - markers.get_child(0).global_position.z < 0.3 && self.position.z - markers.get_child(0).global_position.z > -0.3:
				if $StandTimer.is_stopped()==true:
					$StandTimer.start(5)
				self.position = markers.get_child(0).global_position
				look_at(Vector3(-7, 0, -1.5))
				get_node("NPC1Anim/AnimationPlayer").play("NPC1Idle")
		elif whereToGo == 1:
			nav.target_position = markers.get_child(1).global_position
			self.get_position_delta()
		elif whereToGo == 2:
			nav.target_position = markers.get_child(2).global_position
			self.get_position_delta()
			if self.position.x - markers.get_child(2).global_position.x < 0.3 && self.position.x - markers.get_child(2).global_position.x > -0.3 && self.position.y - markers.get_child(2).global_position.y < 0.3 && self.position.y - markers.get_child(2).global_position.y > -0.3 && self.position.z - markers.get_child(2).global_position.z < 0.3 && self.position.z - markers.get_child(2).global_position.z > -0.3:
				if $StandTimer.is_stopped()==true:
					$StandTimer.start(5)
				self.position = markers.get_child(2).global_position
				look_at(Vector3(-7, 2.5, 0))
				get_node("NPC1Anim/AnimationPlayer").play("NPC1Idle")
		elif whereToGo == 3:
			nav.target_position = markers.get_child(3).global_position
			self.get_position_delta()
	else:
		SPEED = 2.8
		if onFloor0 == true && player.onFloor0 == false:
			if player.position.x > 2.36:
				nav.target_position = markers.get_child(4).global_position
			else:
				nav.target_position = markers.get_child(1).global_position
		elif onFloor0 == false && player.onFloor0 == true:
			if self.position.x > 2.36:
				nav.target_position = markers.get_child(5).global_position
			else:
				nav.target_position = markers.get_child(3).global_position
		elif onFloor0 == false && player.onFloor0 == false:
			if self.position.x < 2.36 && player.position.x > 2.36:
				nav.target_position = markers.get_child(3).global_position
			elif self.position.x > 2.36 && player.position.x < 2.36:
				nav.target_position = markers.get_child(5).global_position
			else:
				nav.target_position = player.global_position
		else:
			nav.target_position = player.global_position
	direction = nav.get_next_path_position() - global_position
	run_door_interaction()
	
	velocity = velocity.lerp(direction*SPEED, SPEED*delta)
	if (velocity.x > 0.1 || velocity.x < -0.1) || (velocity.z > 0.1 || velocity.z < -0.1):
		if player.spotted == false:
			get_node("NPC1Anim/AnimationPlayer").play("NPC1Walking")
		else:
			get_node("NPC1Anim/AnimationPlayer").play("NPC1Running")
		look_at(Vector3(nav.target_position))
	else:
		get_node("NPC1Anim/AnimationPlayer").play("NPC1Idle")
	for collision_index in get_slide_collision_count():
		var collision = get_slide_collision(collision_index)
		if collision.get_collider() is CharacterBody3D and "NPCs" not in collision.get_collider():
			test.lost = true
			test.endGame = true;
	move_and_slide()

func door_interaction(From, To, ActuallFloor, Floor, marker, whichFloor):
	if ((self.position.x >= From.position.x - 1 and self.position.x <= From.position.x + 1)
	and (self.position.y > ActuallFloor and self.position.y < ActuallFloor + FloorHeight)
	and (self.position.z >= From.position.z - 1 and self.position.z <= From.position.z + 1)):
		self.position.x = To.position.x
		self.position.y = Floor
		self.position.z = To.position.z + 2
		whereToGo = marker
		onFloor0 = whichFloor

func run_door_interaction():
	door_interaction(Door0floorMiddle, Door1floorMiddle, Floor0, Floor1, 2, false)
	door_interaction(Door1floorMiddle, Door0floorMiddle, Floor1, Floor0, 0, true)
	door_interaction(Door1floorRight, Door0floorRight, Floor1, Floor0, 0, true)
	door_interaction(Door0floorRight, Door1floorRight, Floor0, Floor1, 0, false)

func _on_vision_timer_timeout():
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var playerPos = overlap.global_transform.origin
				$VisionRayCast.look_at(playerPos, Vector3.UP)
				$VisionRayCast.force_raycast_update()
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					if collider.name == "Player":
						player.spotted = true


func _on_stand_timer_timeout():
	$StandTimer.stop()
	whereToGo = whereToGo + 1
