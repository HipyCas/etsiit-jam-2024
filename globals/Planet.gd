extends Node

const PLANETS = {
	1: {
		'name': 'Kanter',
		'description': 'Templado para su cercanía a la estrella. Pobre en recursos. Contiene: H C Fe',
		'motor_lvl': 0,
		'cost': {}
	},
	2: {
		'name': 'Sulvina',
		'description': 'Cálido. Variedad de zonas áridas y húmedas. Contiene: H C Fe Si Cu Li',
		'motor_lvl': 1,
		'cost': {
			'hydrogen': 50,
			'electricity': 20,
		}
	},
	3: {
		'name': 'Briker',
		'description': 'Muy frío. Caída regular de cometas. Contiene: H C Fe Si Cu Li W Pd',
		'motor_lvl': 2,
		'cost': {
			'hydrogen': 100,
			'electricity': 60,
		}
	},
	4: {
		'name': 'Outer space (Espacio exterior)',
		'description': 'Continuar el viaje programado',
		'motor_lvl': 3,
		'cost': {
			'hydrogen': 170,
			'electricity': 200,
		}
	}
}

var _current_planet = 1


func can_travel_to(planet: int):
	if planet < 1 or planet > PLANETS.size():
		return false
	
	var costs_match = true
	for element in PLANETS[planet].cost.keys():
		if not Inventory.inventory.has(element):
			return false
		elif Inventory.inventory[element] < PLANETS[planet].cost[element]:
			costs_match = false
	
	return costs_match and Inventory.inventory.Motor >= PLANETS[planet].motor_lvl

func goto_planet(planet: int):
	if can_travel_to(planet):
		DroneManager.cancel_mission()
		_current_planet = planet

func get_current_planet():
	return _current_planet

func get_planet(planet: int):
	return null if planet < 1 or planet > PLANETS.size() else PLANETS[planet]
