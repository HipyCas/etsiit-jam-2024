extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	actualizar_lista()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#actualizar_lista()
	pass


var crafter_items = {
	#Costes de crafteos
	#Nombre del item, costes
	"Motor Nv 1                        10Z 60Fe": {'cost':{'electricity':-10,'Fe':-60,'Motor':1}, 'unlocked': true},
	"Motor Nv 2                  30Z 150Fe 50Si": {'cost':{'electricity':-30,'Fe':-150,'Si':-50,'Motor':1}, 'unlocked': false, 'dependencies': {'Motor':1, 'Crafter':2 }},
	"Motor FTL               50Z 250Fe 50W 40Pd": {'cost':{'electricity':-50,'Fe':-250,'W':-50,'Pd':-40,'Motor':1}, 'unlocked': false, 'dependencies': {'Motor':2, 'Crafter':3 }},
	"Batería Nv 2                      10Z 50Li": {'cost':{'electricity':-10,'Li':-50,'Battery':1,'Battery_max':200}, 'unlocked': true},
	"Batería Nv 3                30Z 70Li 200Cu": {'cost':{'electricity':-30,'Li':-70,'Cu':-200,'Battery':1,'Battery_max':200}, 'unlocked': false, 'dependencies': {'Battery':2, 'Crafter':2 }},
	"Batería Nv 4                 60Z 100Li 20W": {'cost':{'electricity':-60,'Li':-100,'W':-20,'Battery':1,'Battery_max':200}, 'unlocked': false, 'dependencies': {'Battery':3, 'Crafter':3 }},
	"Caldera Nv 2                      10Z 20Fe": {'cost':{'electricity':-10,'Fe':-20,'Heater':1}, 'unlocked': true},
	"Caldera Nv 3                40Z 150Cu 40Fe": {'cost':{'electricity':-40,'Cu':-150,'Fe':-40,'Heater':1}, 'unlocked': false, 'dependencies': {'Heater':2, 'Crafter':2 }},
	"Caldera Nv 4               60Z 300Cu 100Si": {'cost':{'electricity':-60,'Cu':-300,'Si':-100,'Heater':1}, 'unlocked': false, 'dependencies': {'Heater':3, 'Crafter':3 }},
	"Crafter Nv 2                 20Z 60Fe 30Si": {'cost':{'electricity':-20,'Fe':-60,'Si':-30,'Crafter':1}, 'unlocked': true},
	"Crafter Nv 3                  50Z 70Fe 30W": {'cost':{'electricity':-50,'Fe':-70,'W':-30,'Crafter':1}, 'unlocked': false, 'dependencies': {'Crafter':3 }},
	#"Respirador Nv 2": {'cost':{'electricity':35,'C':20,'Cu':150}, 'unlocked': false, 'dependencies': {'Crafter':2 }},
	#"Respirador Nv 3": {'cost':{'electricity':70,'C':40,'Li':80}, 'unlocked': false, 'dependencies': {'Respirador':2, 'Crafter':3 }},
	"Panel solar Nv 1                  10Z 25Si": {'cost':{'electricity':-10,'Si':-25,'SolarPannel':1,'SolarPannel_production':25}, 'unlocked': false, 'dependencies': {'Crafter':2 }},
	"Panel solar Nv 2            20Z 50Si 150Cu": {'cost':{'electricity':-20,'Si':-50,'Cu':-150,'SolarPannel':1,'SolarPannel_production':25}, 'unlocked': false, 'dependencies': {'SolarPannel':1, 'Crafter':3 }},
	"Panel solar Nv 3              80Z 75Si 40W": {'cost':{'electricity':-80,'Si':-75,'W':-40,'SolarPannel':1,'SolarPannel_production':25}, 'unlocked': false, 'dependencies': {'SolarPannel':2, 'Crafter':3 }}
}

func is_crafteable(item):
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
				if material in Inventory.inventory and Inventory.inventory[material] >= -1*cost[material]:
					# If any required material is insufficient, set unlocked flag to false
					crafteable = false
	print('Objetos Crafteables:', crafteable_list)
	return item in crafteable_list


func unlock():
	var unlocked_items = []
	# Iterate through each item in crafter_items dictionary
	for item_name in crafter_items.keys():
		var item_data = crafter_items[item_name]
		# Check if the item is already unlocked or not
		if not item_data.unlocked:
			#print (item_name + 'no esta desbloqueado')
			var dependencies_met = true
			# Check if the item has dependencies
			if 'dependencies' in item_data:
				print ('hay dependencias')
				var dependencies = item_data.dependencies
				# Iterate through each dependency of the item
				for dependency_name in dependencies.keys():
					# Check if the dependency is unlocked
					if dependency_name in Inventory.inventory and Inventory.inventory[dependency_name] > dependencies[dependency_name]:
						dependencies_met = false
						break  # No need to check further dependencies if one is not met
			# If all dependencies are met, unlock the item
			if dependencies_met:
				crafter_items[item_name].unlocked = true
				unlocked_items.append(item_name)
	print('Objetos Desbloqueados:', unlocked_items)


func actualizar_lista():
	var lista = $ScrollContainer/VBoxContainer
	# Borra todos los elementos de la lista antes de actualizar
	for child in lista.get_children():
		lista.remove_child(child)
	for item_name in crafter_items.keys():
		var item_data = crafter_items[item_name]
		var item_button = Button.new()
		# Define el texto del botón con el nombre del elemento
		item_button.text = item_name
		# Si el elemento está desbloqueado, habilita el botón
		item_button.disabled = not item_data.unlocked
		# Si el elemento está desbloqueado, conecta la señal 'pressed' al método correspondiente
		if item_data.unlocked:
			var method_callable = Callable(self, "craft_item")
			item_button.connect("pressed", method_callable.bind(item_name))
		lista.add_child(item_button)

# Método para manejar la artesanía de un elemento específico
func craft_item(item_name):
	print("Attempting to craft item with name: ", item_name)
	var item_data = crafter_items[item_name]
	if is_crafteable(item_data):
		# Resta los materiales del inventario
		if 'cost' in item_data:
			var cost = item_data.cost
			for material in cost:
				if material in Inventory.inventory:
					Inventory.add_inventory(material, cost[material])
					crafter_items[item_name].unlocked = false
					$AudioStreamPlayer.play()
					actualizar_lista()
					unlock()
				else:
					print("Material", material, "not found in inventory.")
	else: 
		print('No se puede craftear '+ item_name )
