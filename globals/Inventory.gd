extends Node

const INITIAL_INVENTORY = { 
	'electricity': 10
	,'H': 0
	,'Fe': 0
	,'C': 0
	,'Si': 0
	,'Cu': 0
	,'Li': 0
	,'W': 0
	,'Pd': 0
	,'Motor': 0
	,'Respirador': 1
	,'Battery': 1
	,'SolarPannel': 0
	,'Crafter': 1
	,'Heater': 1
}

var inventory = INITIAL_INVENTORY.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity

var crafter_items = {
	#Costes de crafteos
	#Nombre del item, costes
	"Motor Nv 1": {'cost':{'electricity':10,'Fe':2}, 'unlocked': true}, #dependecies: {"Motor Nv 1"}}
	"Motor Nv 2": {'cost':{'electricity':10,'Fe':6, 'Si':2, 'Cu':2}, 'unlocked': false, 'dependencies': {'Motor':1, 'Crafter':1 }},
	"Motor FTL": {'cost':{'electricity':10,'Fe':2, 'W':2, 'Pd':2}, 'unlocked': false, 'dependencies': {}},
	"Batería Nv 2": {'cost':{'electricity':10,'Li':6}, 'unlocked': true, 'dependencies': {}},
	"Batería Nv 3": {'cost':{'electricity':10,'Li':6, 'Cu':2}, 'unlocked': false, 'dependencies': {}},
	"Batería Nv 4": {'cost':{'electricity':10,'Li':6, 'Cu':2}, 'unlocked': false, 'dependencies': {}},
	"Caldera Nv 2": {'cost':{'electricity':10,'Fe':6}, 'unlocked': true, 'dependencies': {}},
	"Caldera Nv 3": {'cost':{'electricity':10,'Cu':6, 'Fe':2}, 'unlocked': false},
	"Caldera Nv 4": {'cost':{'electricity':10,'Cu':6, 'W':2}, 'unlocked': false},
	"Crafter Nv 2": {'cost':{'electricity':10,'Fe':6, 'Si':2}, 'unlocked': true},
	"Crafter Nv 3": {'cost':{'electricity':10,'Fe':6, 'W':2}, 'unlocked': false},
	"Respirador Nv 2": {'cost':{'electricity':10,'C':6, 'Cu':2}, 'unlocked': false},
	"Respirador Nv 3": {'cost':{'electricity':10,'C':6, 'Li':2}, 'unlocked': false},
	"Panel solar Nv 1": {'cost':{'electricity':10, 'Si':2}, 'unlocked': false},
	"Panel solar Nv 2": {'cost':{'electricity':10, 'Si':2, 'Cu':2}, 'unlocked': false},
	"Panel solar Nv 3": {'cost':{'electricity':10, 'Si':2, 'W':2}, 'unlocked': false}
}

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
			var costs = item_data.cost
			# Iterate through each material required for crafting
			for material in costs.keys():
				if material in inventory and inventory[material] > costs[material]:
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



