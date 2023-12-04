extends CanvasLayer

@onready var anim = get_node("Anim")

func _on_close_pressed():
	anim.play("TransOut")
	get_node("Inventory/Close").process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("Inv"):
		get_node("Inventory/Close").process_mode = Node.PROCESS_MODE_ALWAYS
		if($Inventory.position.y == -650) or ($Inventory.position.y == 650):
			anim.play("TransIn")
			get_tree().paused = true
		elif $Inventory.position.y == 0:
			anim.play("TransOut")
			get_tree().paused = false
		
		$Inventory/InvContainer.fillInventorySlots()
