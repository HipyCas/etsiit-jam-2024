extends Node2D

class_name StateMachine

var init_inventory = { 
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

var inventory = init_inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_inventory(material, quantity):
	inventory[material] += quantity
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


var crafter_costs = {
	#Costes de crafteos
	#Nombre del item, costes
	"Motor Nv 1": {'electricity':10,'Fe':2},
	"Motor Nv 2": {'electricity':10,'Fe':6, 'Si':2, 'Cu':2},
	"Motor FTL": {'electricity':10,'Fe':2, 'W':2, 'Pd':2},
	"Batería Nv 2": {'electricity':10,'Li':6, 'Cu':2},
	"Batería Nv 3": {'electricity':10,'Li':6, 'Cu':2},
	"Caldera Nv 2": {'electricity':10,'Cu':6, 'Fe':2},
	"Caldera Nv 3": {'electricity':10,'Cu':6, 'W':2},
	"Crafter Nv 2": {'electricity':10,'Fe':6, 'Si':2},
	"Crafter Nv 3": {'electricity':10,'Fe':6, 'W':2},
	"Respirador Nv 2": {'electricity':10,'C':6, 'Cu':2},
	"Respirador Nv 3": {'electricity':10,'C':6, 'Li':2},
	"Panel solar Nv 1": {'electricity':10, 'Si':2},
	"Panel solar Nv 2": {'electricity':10, 'Si':2, 'Cu':2},
	"Panel solar Nv 3": {'electricity':10, 'Si':2, 'W':2}
} 

