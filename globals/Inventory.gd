extends Node

const INITIAL_INVENTORY = { 
	'electricity': 1000,
	'hydrogen': 	100,
	'iron': 		100,
	'carbon': 		100,
	'silicon': 		100,
	'lithium': 		100,
	'copper': 		100,
	'tungsten': 	100,
	'paladium': 	100,
	'Motor': 		1,
	'Respirador': 	1,
	'Battery': 		1,
	'SolarPannel': 	1,
	'Crafter': 		1,
	'Heater': 		1,
	'Battery_max': 	200,
	'SolarPannel_production': 0,
}

var inventory = INITIAL_INVENTORY.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity




