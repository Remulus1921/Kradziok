extends Node

var furnitureId = 0;

var items = {
	0: {
		"Name": "Łańcuszek",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	1: {
		"Name": "Złoto",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	2: {
		"Name": "Pierścień",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	3: {
		"Name": "Pierścień władzy",
		"Cost": 1000,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	4: {
		"Name": "Pieniądze",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	5: {
		"Name": "Zegarek",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	6: {
		"Name": "Diamenty",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	7: {
		"Name": "Drogie 1",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	8: {
		"Name": "Drogie 2",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	9: {
		"Name": "Drogie 2",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	10: {
		"Name": "Łyżeczka",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	11: {
		"Name": "Szczotka do włosów",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	12: {
		"Name": "Szmaciana lalka",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	13: {
		"Name": "Czerstwy chleb",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	14: {
		"Name": "Butelka wody",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	15: {
		"Name": "Miska",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	16: {
		"Name": "Widelec",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	17: {
		"Name": "Szklanka",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	18: {
		"Name": "Długopis",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
	19: {
		"Name": "Pusta puszka",
		"Cost": 200,
		"Desc": "Gold Chain my G",
		"Icon": preload("res://icon.svg"),
	},
}

var inventory = {
	
}

var furnitureItem = {
	
}

func addItem(itemName): 
	for i in items: 
		if inventory.size() < 10:
			if items[i]["Name"] == itemName:
				inventory[inventory.size()] = items[i]
				inventory[inventory.size() - 1]["InventoryItem"] = true
	
	
	
