extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button.grab_focus()

func _dismiss():
	GameTime.resume_time()
	get_tree().paused = true
	queue_free()

func _input(event):
	_on_gui_input(event)

func _on_gui_input(event):
	print('pres', event.as_text())
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			_dismiss()


func _on_button_pressed():
	print('dismiss')
	_dismiss()
