extends State
class_name MoveState

var player

func _ready():
	player = get_parent()
	animation.travel("Walk")

func _physics_process(delta):
	if player.direction:
		player.player_mesh.rotation.y = lerp_angle(player.player_mesh.rotation.y, atan2(player.direction.x, player.direction.z) - player.rotation.y, delta * 10)
		player.velocity.x = player.direction.x * player.SPEED
		player.velocity.z = player.direction.z * player.SPEED
	else: 
		player.change_state("idle")
	
	
func exit():
	pass
