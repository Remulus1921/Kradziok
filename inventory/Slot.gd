extends Panel

@onready var itemInfo = $"../../ItemInfo"

var ItemName = ""
var ItemDesc = ""
var ItemCost = 0

var hasItem = false
var mouseEntered = false

func _process(delta):
	if hasItem: 
		$Icon.show()
		$Cost.show()
		$Cost.text = str(ItemCost) + "$"
	else:
		$Icon.hide()
		$Cost.hide()



func _on_mouse_entered():
	if hasItem:
		mouseEntered = true


func _on_mouse_exited():
	mouseEntered = false
	

func _input(event):
	if event.is_action_pressed("LeftClick"):
		if mouseEntered:
			itemInfo.get_node("Anim").play("TransIn")
			itemInfo.ItemName = ItemName
			itemInfo.ItemCost = ItemCost
			itemInfo.ItemDesc = ItemDesc
			itemInfo.get_node("Icon").texture = $Icon.texture
			itemInfo.updateInfo()
			get_node("../../").process_mode = Node.PROCESS_MODE_DISABLED
