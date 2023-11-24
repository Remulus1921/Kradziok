extends Node


var items = {
	0: {
		"Name": "Chain",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
}

var inventory = {
	0: {
		"Name": "Chain",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
}

func addItem(itemName): 
	var hasItem = false
	for i in inventory:
		if inventory[i]["Name"] == itemName:
			inventory[i]["Count"] += 1
			hasItem = true
	
	if hasItem == false:
		for i in items: 
			if items[i]["Name"] == itemName:
				var tempDic = items[i]
				tempDic["Count"] = 1
				inventory[inventory.size()] = tempDic
	
	
	
