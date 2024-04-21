extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _unhandled_input(event):
	if event is InputEventKey and event.pressed and GameTime.running:
		if event.keycode == KEY_LEFT:
			rotate(Vector3.UP, PI * 0.5)
		elif event.keycode == KEY_RIGHT:
			rotate(Vector3.DOWN, PI * 0.5)

