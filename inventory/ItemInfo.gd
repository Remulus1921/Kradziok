extends CanvasLayer

@onready var anim = get_node("Anim")

var ItemName = ""
var ItemDesc = ""
var ItemCost = 0
var ItemInInv = false

func updateInfo():
	get_node("Title").text = str(ItemName)
	get_node("Desc").text = str(ItemDesc) + "\nWartość: " + str(ItemCost) + "$" 

func _on_close_pressed():
	get_node("../").process_mode = Node.PROCESS_MODE_ALWAYS
	anim.play("TransOut")


func _on_take_pressed():
	if Inv.inventory.size() <= 10:
		Inv.addItem(ItemName)
		for f in Inv.furnitureItem[Inv.furnitureId]:
			if Inv.furnitureItem[Inv.furnitureId][f]["Name"] == ItemName:
				var tempDic = {}
				for x in Inv.furnitureItem[Inv.furnitureId]:
					if x > f: 
						tempDic[x-1] = Inv.furnitureItem[Inv.furnitureId][x]
					elif x < f:
						tempDic[x] = Inv.furnitureItem[Inv.furnitureId][x]
				Inv.furnitureItem[Inv.furnitureId].clear()
				Inv.furnitureItem[Inv.furnitureId] = tempDic
				_on_close_pressed()
				get_node("../Inventory").fillInventorySlots()
				get_node("../Furniture").fillFurnitureSlots()
	_on_close_pressed()


func _on_drop_pressed():
	if Inv.furnitureItem[Inv.furnitureId].size() <= 10:
		for i in Inv.items:
			if Inv.items[i]["Name"] == ItemName:
				Inv.furnitureItem[Inv.furnitureId][Inv.furnitureItem[Inv.furnitureId].size()] = Inv.items[i]
				var tempDic = {}
				for x in Inv.inventory: 
					if x > i: 
						tempDic[x-1] = Inv.inventory[x]
					elif x < i:
						tempDic[x] = Inv.inventory[x]
				Inv.inventory.clear()
				Inv.inventory = tempDic
				_on_close_pressed()
				get_node("../Inventory").fillInventorySlots()
				get_node("../Furniture").fillFurnitureSlots()
	_on_close_pressed()
