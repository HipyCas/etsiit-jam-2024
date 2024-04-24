extends Node3D

const MAP_SCENE = preload("res://PlanetSelection.tscn")
const CALDERA_OVERLAY = preload("res://caldera_provisional.tscn")
const CRAFTER_OVERLAY = preload("res://crafter_provisional.tscn")
const DRONE_OVERLAY = preload("res://DroneMissionSelect.tscn")
const END_GAME_SCREEN = preload("res://end_game.tscn")

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


func _on_static_caldera_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var sc = CALDERA_OVERLAY.instantiate()
			#get_node("/root/Main").visible = false
			get_tree().root.add_child(sc)


func _on_static_dron_control_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var sc = DRONE_OVERLAY.instantiate()
			#get_node("/root/Main").visible = false
			get_tree().root.add_child(sc)


func _on_timer_timeout():
	if GameTime.running:
		Inventory.add_inventory(
			'electricity',
			# The 43.2 is 12h * 60min * 60s / (5s * MUTLIPLIER), as this got to be a daily quantity but each 5s
			(Inventory.inventory['SolarPannel_production']
			- 40 + (14 * GameTime.days_elapsed)) / 43.2
		)
		if Inventory.inventory['electricity'] <= 0:
			var scr = END_GAME_SCREEN.instantiate()
			scr.get_node("Content/Title").text = "¡Te has quedado sin oxígeno!"
			get_tree().root.add_child(scr)
		else:
			#$SolarPanelProd/Label.text = "+" + String.num(Inventory.inventory['SolarPannel_production'], 0)
			$BateriaTotal.text = String.num(Inventory.inventory['electricity'], 0) + "/" + String.num(Inventory.inventory['Battery_max'])
			$BateriaConsumo.text = "-" + String.num(40 + (14 * GameTime.days_elapsed), 0)


func _on_static_crafter_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var sc = CRAFTER_OVERLAY.instantiate()
			#get_node("/root/Main").visible = false
			get_tree().root.add_child(sc)
