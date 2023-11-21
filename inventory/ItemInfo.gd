extends CanvasLayer

@onready var anim = get_node("Anim")

var ItemName = ""
var ItemDesc = ""
var ItemCost = 0

func updateInfo():
	get_node("Title").text = str(ItemName)
	get_node("Desc").text = str(ItemDesc) + "\nWartość: " + str(ItemCost) + "$" 

func _on_close_pressed():
	get_node("../").process_mode = Node.PROCESS_MODE_ALWAYS
	anim.play("TransOut")
