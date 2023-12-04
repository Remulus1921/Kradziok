extends Panel

@onready var itemInfo = $"../../ItemInfo"

var ItemName = ""
var ItemDesc = ""
var ItemCost = 0
var ItemInInv = false

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
	var parent = get_parent()
	parent = parent.get_parent()
	if event.is_action_pressed("LeftClick"):
		if mouseEntered:
			if parent.get_name() == "Control":
				if ItemInInv:
					itemInfo.get_node("Drop").show()
					itemInfo.get_node("Take").hide()
				elif !ItemInInv: 
					itemInfo.get_node("Drop").hide()
					itemInfo.get_node("Take").show()
			else:
				itemInfo.get_node("Drop").hide()
				itemInfo.get_node("Take").hide()
			itemInfo.get_node("Anim").play("TransIn")
			itemInfo.ItemName = ItemName
			itemInfo.ItemCost = ItemCost
			itemInfo.ItemDesc = ItemDesc
			itemInfo.ItemInInv = ItemInInv
			itemInfo.get_node("Icon").texture = $Icon.texture
			itemInfo.updateInfo()
			get_node("../../").process_mode = Node.PROCESS_MODE_DISABLED
