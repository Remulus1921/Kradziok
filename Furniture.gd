extends GridContainer

@onready var slot = preload("res://inventory/Slot.tscn")
var invSize = 10

func _ready():
	for i in invSize:
		var slotTemp = slot.instantiate()
		add_child(slotTemp)

func fillFurnitureSlots():
	var items = Inv.furnitureItem[Inv.furnitureId]
	for i in invSize:
		get_child(i).ItemName = ""
		get_child(i).ItemDesc = ""
		get_child(i).ItemCost = 0
		get_child(i).hasItem = false
	
	for i in items:
		get_child(i).ItemName = items[i]["Name"]
		get_child(i).ItemDesc = items[i]["Desc"]
		get_child(i).ItemCost = items[i]["Cost"]
		get_child(i).ItemInInv = items[i]["InventoryItem"]
		get_child(i).hasItem = true
		get_child(i).get_node("Icon").texture = (items[i]["Icon"])
