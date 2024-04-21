extends Node

const INITIAL_INVENTORY = { 
	'electricity': 1000,
	'hydrogen': 		0,
	'iron': 				600,
	'carbon': 			0,
	'silicon': 			100,
	'lithium': 			0,
	'copper': 			0,
	'tungsten': 		0,
	'paladium': 		0,
	'Motor': 				0,
	'Respirador': 	1,
	'Battery': 			1,
	'SolarPannel': 	0,
	'Crafter': 			1,
	'Heater': 			1,
	'Battery_max': 			200,
	'SolarPannel_production': 	0,
}

var inventory = INITIAL_INVENTORY.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity




