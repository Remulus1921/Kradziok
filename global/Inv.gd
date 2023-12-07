extends Node

var furnitureId = 0;

var items = {
	0: {
		"Name": "Łańcuszek",
		"Cost": 300,
		"Desc": "Złoty łańcuszek",
		"Icon": preload("res://Items/Image12.png"),
	},
	1: {
		"Name": "Złoto",
		"Cost": 500,
		"Desc": "Po prostu złoto",
		"Icon": preload("res://Items/Image7.png"),
	},
	2: {
		"Name": "Pierścień",
		"Cost": 50,
		"Desc": "Piękny pierścionek zaręczynowy pewnie jest wiele wart. (Nie wie że diament jest sztuczny)",
		"Icon": preload("res://Items/Image5.png"),
	},
	3: {
		"Name": "Pierścień władcy",
		"Cost": 2000,
		"Desc": "Jeden, by wszystkimi rządzić, Jeden, by wszystkie odnaleźć,
Jeden, by wszystkie zgromadzić i w ciemności związać",
		"Icon": preload("res://Items/Image15.png"),
	},
	4: {
		"Name": "Pieniądze",
		"Cost": 100,
		"Desc": "Jakieś drobne na kawe",
		"Icon": preload("res://Items/Image17.png"),
	},
	5: {
		"Name": "Zegarek",
		"Cost": 500,
		"Desc": "Stylowy Golex",
		"Icon": preload("res://Items/Image20.png"),
	},
	6: {
		"Name": "Diamenty",
		"Cost": 500,
		"Desc": "Dwa małe ale piękne diamenciki",
		"Icon": preload("res://Items/Image8.png"),
	},
	7: {
		"Name": "Korale",
		"Cost": 75,
		"Desc": "Podobno to te piękne korale które Król Karol kupił królowej Karolinie korale koloru koralowego",
		"Icon": preload("res://Items/Image16.png"),
	},
	8: {
		"Name": "Check",
		"Cost": 600,
		"Desc": "Check opiewający na cudowną kwotę, miejmy nadzieję że nie jest bez pokrycia",
		"Icon": preload("res://Items/Image14.png"),
	},
	9: {
		"Name": "Telefon",
		"Cost": 50,
		"Desc": "Zbita szybka",
		"Icon": preload("res://Items/Image13.png"),
	},
	10: {
		"Name": "WePhone",
		"Cost": 1000,
		"Desc": "To nie telefon to WePhone",
		"Icon": preload("res://Items/Image11.png"),
	},
	11: {
		"Name": "Laptop",
		"Cost": 700,
		"Desc": "Fajny gdyby nie to że ma klawiaturę z podświetleniem RGB",
		"Icon": preload("res://Items/Image6.png"),
	},
	12: {
		"Name": "Świnka skarbonka",
		"Cost": 10,
		"Desc": "ALe słodka, może ją przygarniesz?",
		"Icon": preload("res://Items/Image4.png"),
	},
	13: {
		"Name": "Naszyjnik z bursztynami",
		"Cost": 450,
		"Desc": "Nie mam nic więcej do dodania, po prostu piękna rzecz",
		"Icon": preload("res://Items/Image10.png"),
	},
	14: {
		"Name": "Kolczyki",
		"Cost": 30,
		"Desc": "Kolczyki domowej roboty",
		"Icon": preload("res://Items/Image18.png"),
	},
	15: {
		"Name": "Bransoleta",
		"Cost": 500,
		"Desc": "Dziwna ta moda żeby wygiętą śrubę noszić jako bransoletę",
		"Icon": preload("res://Items/Image19.png"),
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
	
	
	
