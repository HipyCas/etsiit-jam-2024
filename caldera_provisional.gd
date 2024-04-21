extends Node2D

var heater_items = {
	#Costes de crafteos
	#Nombre del item, costes
	"hydrogen": {'cost':10,'production':{1:5,2:5,3:5,4:5}},
	"lithium": {'cost':10, 'production':{1:5,2:5,3:5,4:5}},
	"carbon": {'cost':10, 'production':{1:5,2:5,3:5,4:5}}
}

# Declarar una variable para llevar el seguimiento del estado actual del botón
var elemento_horno_actual = -1
# Declarar una lista de valores de texto
var elementos_horno = []
var element_name = ''
var battery_max={1:200, 2:400, 3:600, 4:800} #level:electricity
var heater_element_level_production = {} 

var heater_level = Inventory.inventory['Heater']

# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar la lista de elementos de horno con los nombres de los elementos
	for item_name in heater_items.keys():
		elementos_horno.append(item_name)
	
	var heater_level = Inventory.inventory['Heater']
	var battery_max_level = battery_max[Inventory.inventory['Battery']]
	
	_on_element_button_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Función llamada cuando el botón es presionado
func _on_element_button_pressed():
	# Incrementar el estado actual y asegurarse de que no exceda el número de elementos del horno
	elemento_horno_actual += 1
	if elemento_horno_actual >= elementos_horno.size():
		elemento_horno_actual = 0
	# Cambiar el texto del botón al valor correspondiente
	var battery_max_level = battery_max[Inventory.inventory['Battery']]
	var element_name = elementos_horno[elemento_horno_actual]
	var element_inventory = Inventory.inventory[element_name]
	var cost = heater_items[element_name].cost
	var production = heater_items[element_name].production[heater_level]

	$HeaterElementButton.text = element_name
	$electricity_actual_y_maximo.text = str(Inventory.inventory['electricity']) + " / " + str(battery_max_level)
	var cantidad_coste = str(element_inventory) + " / " + str(cost) + " => " + str(production)
	$element_cantidad_y_coste.text = cantidad_coste
	

func _on_heater_fire_button_pressed():
	var battery_max_value = battery_max[Inventory.inventory['Battery']]
	var heater_level = Inventory.inventory['Heater']
	#$electricity_actual_y_maximo.text = str(Inventory.inventory['electricity']) + " / " + str(battery_max_level)
	if  Inventory.inventory['electricity'] < battery_max_value:
		var element_name = elementos_horno[elemento_horno_actual]
		#print(heater_items[element_name])
		Inventory.add_inventory('electricity', heater_items[element_name].production[heater_level])
		#Inventory.add_inventory(element_name, heater_items[element_name].cost)
		$electricity_actual_y_maximo.text = str(Inventory.inventory['electricity']) + " / " + str(battery_max_value)
	
