extends Node

const INITIAL_INVENTORY = { 
	'electricity': 1000,
	'hydrogen': 	1000,
	'iron': 		1000,
	'carbon': 		1000,
	'silicon': 		1000,
	'lithium': 		1000,
	'copper': 		1000,
	'tungsten': 	1000,
	'paladium': 	1000,
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




