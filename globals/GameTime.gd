extends Node

const DIARY_OVERLAY_SCENE = preload("res://DiaryView.tscn")

# 12h game time -> 10min -> 5min real time
const MULTIPLIER = 72 * 2;

var raw_time = 0
var days_elapsed = 0
var running = true

var hooks = []

func _process(delta):
	if running:
		raw_time += delta
	
	if get_day() > days_elapsed:
		# This is probably what caused the problem
		#get_tree().paused = true
		#emit_signal('day_gone')
		days_elapsed += 1
		
		for hook in hooks:
			hook.call()
		
		pause_time()
		
		_show_diary_overlay()

func add_daily_hook(fn):
	hooks.push_back(fn)

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
	
	if diary_file == null:
		print('No more diaries')
		resume_time()
		return
	
	this_scene.get_node("VBoxContainer/RichTextLabel").append_text(diary_file.get_as_text())
	
	get_tree().root.add_child(this_scene)
