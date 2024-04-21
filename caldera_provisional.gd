extends Node2D

# Declarar una variable para llevar el seguimiento del estado actual del botón
var elemento_horno_actual = 0
# Declarar una lista de valores de texto
var elementos_horno = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar la lista de elementos de horno con los nombres de los elementos
	for item_name in Inventory.heater_items.keys():
		elementos_horno.append(item_name)

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
	var element_name = elementos_horno[elemento_horno_actual]
	var element_inventory = Inventory.inventory[element_name]
	var cost = Inventory.heater_items[element_name].cost
	var production = Inventory.heater_items[element_name].production
	
	$HeaterElementButton.text = element_name
		
	$cantidad_coste.text = str(element_inventory) + " / " + str(cost) + " => " + str(production)
	

