extends Node

var random = RandomNumberGenerator.new()
func _ready():
	random.randomize()

const ELEMENTS = ['hydrogen', 'iron', 'carbon', 'silicon', 'lithium', 'copper', 'tungsten', 'paladium']

# TODO Add ranking/priority 
var CONDITIONS = {
	'Hay lagos cerca.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'hydrogen': func(n): return n + 10,
			'silicon': func(n): return n * 0.5,
		}
	},
	'Zona parcialmente húmeda.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'hydrogen': func(n): return n + 15,
			'silicon': func(n): return n * 0.2,
		}
	},
	'Lodazal colosal en la zona.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'hydrogen': func(n): return n + 20,
			'silicon': func(n): return n * 0.1,
		}
	},
	'20% de probabilidad de lluvia.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'hydrogen': func(n): return n + 30 if random.randi_range(0, 100) <= 20 else n,
			'silicon': func(n): return 0 if random.randi_range(0, 100) <= 20 else n,
		}
	},
	'50% de probabilidad de lluvia.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'hydrogen': func(n): return n + 30 if random.randi_range(0, 100) <= 50 else n,
			'silicon': func(n): return n * 0.05 if random.randi_range(0, 100) <= 50 else n,
		}
	},
	'20% de probabilidad de tormenta.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'hydrogen': func(n): return n + 40 if random.randi_range(0, 100) <= 20 else n,
			'silicon': func(n): return 0 if random.randi_range(0, 100) <= 20 else n,
		}
	},
	'Hay árboles cerca.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'carbon': func(n): return n + 10,
			'copper': func(n): return n * 0.1,
		}
	},
	'Vegetanción frondosa.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'carbon': func(n): return n + 10,
			'copper': func(n): return n * 0.1,
		}
	},
	'Pradera.': {
		'when': 0, # | 'P1' | 'P2'
		'effects': {
			'carbon': func(n): return n + 5,
			'copper': func(n): return n * 0.5,
		}
	},
	'20% de probabilidad de tormenta eléctrica': {
		'when': 0,
		'effects': {
			'iron': func(n): return 0 if random.randi_range(0, 100) <= 20 else n,
		}
	},
	'50% de probabilidad de tormenta eléctrica': {
		'when': 0,
		'effects': {
			'iron': func(n): return 0 if random.randi_range(0, 100) <= 50 else n,
		}
	},
	'Tormenta eléctrica': {
		'when': 0,
		'effects': {
			'iron': func(n): return 0,
		}
	},
	'Localizado en un cráter': {
		'when': 3,
		'effects': {
			'paladium': func(n): return random.randi_range(5, 11) + n,
		}
	},
	'Cráter en las cercanías': {
		'when': 3,
		'effects': {
			'paladium': func(n): return random.randi_range(0, 5) + n,
		}
	},
	'Caida de vólidos cercanos': {
		'when': 3,
		'effects': {
			'paladium': func(n): return random.randi_range(5, 8) + n,
		}
	},
	'Localizado dentro de un cráter': {
		'when': 3,
		'effects': {
			'paladium': func(n): return random.randi_range(5, 11) + n,
		}
	},
	'Meteorítos en las cercanías': {
		'when': 3,
		'effects': {
			'paladium': func(n): return random.randi_range(0, 5) + n,
		}
	},
	'Agujeros cóncavos pueblan el terreno': {
		'when': 3,
		'effects': {
			'paladium': func(n): return random.randi_range(5, 18) + n,
		}
	}
}

# This value gets multiplied by random between 0 and 1
const PLANET_BASE_RESOURCES = {
	1: {
		'hydrogen': [0, 76],
		'iron': 	[0, 76],
		'carbon': 	[0, 76],
		'silicon': 	[0, 0],
		'lithium': 	[0, 0],
		'copper': 	[0, 0],
		'tungsten': [0, 0],
		'paladium': [0, 0]
	},
	2: {
		
	},
	3: {
		
	},
}

func get_loot_for_element(planet: int, element: String, mods: Array):
	if not PLANET_BASE_RESOURCES.has(planet) or not PLANET_BASE_RESOURCES[planet].has(element):
		return null
	
	var value = random.randi_range(
		PLANET_BASE_RESOURCES[planet][element][0], 
		PLANET_BASE_RESOURCES[planet][element][1]
	)
	
	for mod in mods:
		if mod.effects.has(element):
			value = mod.effects[element].call(value);
	
	return value;

func get_loot_for_planet(planet: int, mods: Array):
	if not PLANET_BASE_RESOURCES.has(planet):
		return null
	
	var loot = {}
	
	for el in ELEMENTS:
		loot[el] = get_loot_for_element(planet, el, mods)
	
	return loot
	
func get_conditions_object(planet: int):
	var availables = []
	var selected = {}
	
	for cond_key in CONDITIONS.keys():
		if CONDITIONS[cond_key]['when'] >= planet:
			availables.push_back([cond_key, CONDITIONS[cond_key]])
	
	# TODO Weighted selection
	while selected.size() < 3:
		var selected_index = random.randi_range(0, len(availables) - 1)
		selected[availables[selected_index][0]] = availables[selected_index][1].duplicate()
		availables.remove_at(selected_index)
		
	return selected;

func conditions_object_to_array(conds: Dictionary):
	return conds.values()

func loot_with_conds(planet: int, conds: Dictionary):
	return get_loot_for_planet(planet, conditions_object_to_array(conds))
