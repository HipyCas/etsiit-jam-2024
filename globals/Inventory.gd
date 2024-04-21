extends Node

const INITIAL_INVENTORY = { 
	'electricity': 10,
	'hydrogen': 		0,
	'iron': 				0,
	'carbon': 			0,
	'silicon': 			0,
	'lithium': 			0,
	'copper': 			0,
	'tungsten': 		0,
	'paladium': 		0,
	'Motor': 				0,
	'Respirador': 	1,
	'Battery': 			1,
	'SolarPannel': 	0,
	'Crafter': 			1,
	'Heater': 			1
}

var inventory = INITIAL_INVENTORY.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity




