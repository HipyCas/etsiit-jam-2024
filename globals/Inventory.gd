extends Node

const INITIAL_INVENTORY = { 
	'electricity': 1000,
	'hydrogen': 	10,
	'iron': 		10,
	'carbon': 		10,
	'silicon': 		10,
	'lithium': 		10,
	'copper': 		10,
	'tungsten': 	10,
	'paladium': 	10,
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

var crafteados=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity




