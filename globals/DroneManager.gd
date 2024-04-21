extends Node

var _ongoing_mission = null
var _ongoing_started_on = 0

var daily_missions = []

func _ready():
	GameTime.add_daily_hook(switch_day)
	gen_daily_missions()

func _process(delta):
	if (mission_ongoing() and
		(
			(Time.get_ticks_msec() - _ongoing_started_on)
			>= _ongoing_mission.mission_length_real_seconds
		)):
		complete_mission()

func gen_daily_missions():
	daily_missions = gen_n_missions(Planet.get_current_planet(), 8)

func switch_day():
	cancel_mission()
	gen_daily_missions()

func cancel_mission():
	_ongoing_mission = null

func complete_mission():
	print('complete mission')
	if not mission_ongoing(): return
	
	var loot = Loot.loot_with_conds(Planet.get_current_planet(), _ongoing_mission.conds)
	print('complete with ', loot)
	for el in loot.keys():
		Inventory.add_inventory(el, loot[el])
	
	cancel_mission()

func mission_ongoing():
	return not _ongoing_mission == null

func lauch_mission(mission_idx: int):
	if _ongoing_mission != null:
		return false
	_ongoing_mission = daily_missions[mission_idx]
	_ongoing_started_on = Time.get_ticks_msec()
	return true

func gen_mission(planet: int):
	var conds = Loot.get_conditions_object(planet)
	
	var mission_length_ingame_hours = Loot.random.randi_range(2, 6)
	var mission_length_real_seconds = (mission_length_ingame_hours * 60 * 60 * 1000) / GameTime.MULTIPLIER
	
	return {
		'conds': conds,
		'mission_length_real_seconds': mission_length_real_seconds,
		'mission_length_ingame_hours': mission_length_ingame_hours,
		'planet': planet,
		'coords': [Loot.random.randi_range(0, 99), Loot.random.randi_range(0, 99)]
	}


func gen_n_missions(planet: int, n: int):
	var miss = []
	for _i in range(n):
		miss.push_back(gen_mission(planet))
	return miss
