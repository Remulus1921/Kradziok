extends CanvasLayer

@onready var anim = get_node("Anim")

func _on_close_pressed():
	anim.play("TransOut")
	get_node("Control/Close").process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	
func fillContainer():
	anim.play("TrnasIn")
	get_node("Control/Close").process_mode = Node.PROCESS_MODE_ALWAYS
	$Control/Inventory.fillInventorySlots()
	$Control/Furniture.fillFurnitureSlots()
	get_tree().paused = true	
