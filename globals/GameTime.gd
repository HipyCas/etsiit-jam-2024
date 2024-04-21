extends Node

const DIARY_OVERLAY_SCENE = preload("res://DiaryView.tscn")

# 12h game time -> 10min -> 5min real time
const MULTIPLIER = 72 * 2;

var raw_time = 0
var days_elapsed = 0
var running = true

func _process(delta):
	raw_time += delta
	
	if get_day() > days_elapsed:
		get_tree().paused = true
		#emit_signal('day_gone')
		days_elapsed += 1
		running = false
		
		_show_diary_overlay()
	
func get_time():
	return raw_time * 72

func get_day():
	return floor(get_time() / (12 * 1 * 60))
	
func pause_time():
	running = false
	
func resume_time():
	running = true

func _show_diary_overlay():
	var this_scene = DIARY_OVERLAY_SCENE.instantiate()
	
	var diary_file = FileAccess.open("res://diaries/" + String.num(get_day(), 0) + ".txt", FileAccess.READ)
	
	this_scene.get_node("Control/VBoxContainer/RichTextLabel").append_text(diary_file.get_as_text())
	
	get_tree().root.add_child(this_scene)
