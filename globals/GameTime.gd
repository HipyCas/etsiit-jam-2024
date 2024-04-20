extends Node

# 12h game time -> 10min real time
const MULTIPLIER = 72;

var raw_time = 0
var days_elapsed = 0
var running = true

func _process(delta):
	raw_time += delta
	
	if get_day() > days_elapsed:
		emit_signal('day_gone')
		days_elapsed += 1
		running = false
	
func get_time():
	return raw_time * 72

func get_day():
	return floor(get_time() / (12 * 60 * 60))
