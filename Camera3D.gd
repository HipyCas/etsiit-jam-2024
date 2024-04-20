extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	print(event.as_text())
	if event is InputEventKey and event.pressed:
		print(event.keycode, event.keycode == KEY_LEFT)
		if event.keycode == KEY_LEFT:
			rotate(Vector3.UP, PI * 0.5)
		elif event.keycode == KEY_RIGHT:
			rotate(Vector3.DOWN, PI * 0.5)

