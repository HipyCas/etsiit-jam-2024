extends Node3D

const MAP_SCENE = preload("res://PlanetSelection.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_static_mapa_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var sc = MAP_SCENE.instantiate()
			get_node("/root/Main").visible = false
			get_tree().root.add_child(sc)
