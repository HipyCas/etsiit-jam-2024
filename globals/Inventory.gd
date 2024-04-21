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

var crafter_items = {
	#Costes de crafteos
	#Nombre del item, costes
	"Motor Nv 1": {'cost':{'electricity':10,'Fe':60}, 'unlocked': true},
	"Motor Nv 2": {'cost':{'electricity':30,'Fe':150, 'Si':50}, 'unlocked': false, 'dependencies': {'Motor':1, 'Crafter':2 }},
	"Motor FTL": {'cost':{'electricity':50,'Fe':250, 'W':50, 'Pd':40}, 'unlocked': false, 'dependencies': {'Motor':2, 'Crafter':3 }},
	"Batería Nv 2": {'cost':{'electricity':10,'Li':50}, 'unlocked': true},
	"Batería Nv 3": {'cost':{'electricity':30,'Li':70, 'Cu':200}, 'unlocked': false, 'dependencies': {'Battery':2, 'Crafter':2 }},
	"Batería Nv 4": {'cost':{'electricity':60,'Li':6, 'W':20}, 'unlocked': false, 'dependencies': {'Battery':3, 'Crafter':3 }},
	"Caldera Nv 2": {'cost':{'electricity':10,'Fe':20}, 'unlocked': true},
	"Caldera Nv 3": {'cost':{'electricity':40,'Cu':150, 'Fe':40}, 'unlocked': false, 'dependencies': {'Heater':2, 'Crafter':2 }},
	"Caldera Nv 4": {'cost':{'electricity':60,'Cu':300, 'Si':100}, 'unlocked': false, 'dependencies': {'Heater':3, 'Crafter':3 }},
	"Crafter Nv 2": {'cost':{'electricity':20,'Fe':60, 'Si':30}, 'unlocked': true},
	"Crafter Nv 3": {'cost':{'electricity':50,'Fe':70, 'W':30}, 'unlocked': false, 'dependencies': {'Crafter':3 }},
	"Respirador Nv 2": {'cost':{'electricity':35,'C':20, 'Cu':150}, 'unlocked': false, 'dependencies': {'Crafter':2 }},
	"Respirador Nv 3": {'cost':{'electricity':70,'C':40, 'Li':80}, 'unlocked': false, 'dependencies': {'Respirador':2, 'Crafter':3 }},
	"Panel solar Nv 1": {'cost':{'electricity':10, 'Si':25}, 'unlocked': false, 'dependencies': {'Crafter':2 }},
	"Panel solar Nv 2": {'cost':{'electricity':20, 'Si':50, 'Cu':150}, 'unlocked': false, 'dependencies': {'SolarPannel':1, 'Crafter':3 }},
	"Panel solar Nv 3": {'cost':{'electricity':80, 'Si':75, 'W':40}, 'unlocked': false, 'dependencies': {'SolarPannel':2, 'Crafter':3 }}
}



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity

func is_crafteable():
	#Determina si un elemento se puede craftear o no
	var crafteable = false
	var crafteable_list = []
	for item_name in crafter_items.keys():
		var item_data = crafter_items[item_name]
		if item_data.unlocked:
			continue  # If already unlocked, skip
			crafteable = true  # Flag to track if all prerequisites are met
			crafteable_list.append(item_name)
		if 'cost' in item_data:
			# Check if the item has crafting costs
			var cost = item_data.cost
			# Iterate through each material required for crafting
			for material in cost.keys():
				if material in inventory and inventory[material] > cost[material]:
					# If any required material is insufficient, set unlocked flag to false
					crafteable = false
	print('Objetos Crafteables:', crafteable_list)
	return crafteable


func unlock():
	var unlocked_items = []
	# Iterate through each item in crafter_items dictionary
	for item_name in crafter_items.keys():
		var item_data = crafter_items[item_name]
		# Check if the item is already unlocked or not
		if not item_data.unlocked:
			var dependencies_met = true
			# Check if the item has dependencies
			if 'dependencies' in item_data:
				var dependencies = item_data.dependencies
				# Iterate through each dependency of the item
				for dependency_name in dependencies.keys():
					# Check if the dependency is unlocked
					if dependency_name in inventory and inventory[dependency_name] > dependencies[dependency_name]:
						dependencies_met = false
						break  # No need to check further dependencies if one is not met
			# If all dependencies are met, unlock the item
			if dependencies_met:
				crafter_items[item_name].unlocked = true
				unlocked_items.append(item_name)
	print('Objetos Desbloqueados:', unlocked_items)



