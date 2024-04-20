extends Node

const DIARY_OVERLAY_SCENE = preload("res://DiaryView.tscn")

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
		
		_show_diary_overlay()
	
func get_time():
	return raw_time * 72

func get_day():
	return floor(get_time() / (12 * 60 * 60))
	
func pause_time():
	running = false
	
func resume_time():
	running = true

func _show_diary_overlay():
	var this_scene = DIARY_OVERLAY_SCENE.instantiate()
	this_scene.get_node("RichTextLabel").add_text("Hi")
	
	get_tree().root.add_child(this_scene)
