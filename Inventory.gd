extends GridContainer


@onready var slot = preload("res://inventory/Slot.tscn")
var invSize = 10

func _ready():
	for i in invSize:
		var slotTemp = slot.instantiate()
		add_child(slotTemp)

func fillInventorySlots():
	for i in invSize:
		get_child(i).ItemName = ""
		get_child(i).ItemDesc = ""
		get_child(i).ItemCost = 0
		get_child(i).hasItem = false
	
	for i in Inv.inventory:
		get_child(i).ItemName = Inv.inventory[i]["Name"]
		get_child(i).ItemDesc = Inv.inventory[i]["Desc"]
		get_child(i).ItemCost = Inv.inventory[i]["Cost"]
		get_child(i).ItemInInv = Inv.inventory[i]["InventoryItem"]
		get_child(i).hasItem = true
		get_child(i).get_node("Icon").texture = (Inv.inventory[i]["Icon"])
