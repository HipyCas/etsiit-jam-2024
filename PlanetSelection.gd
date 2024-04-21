extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera3D.current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_planet_1_input_event(camera, event, position, normal, shape_idx):
	_handle_planet_event(1, event)


func _on_planet_2_input_event(camera, event, position, normal, shape_idx):
	print('planet 2', event.as_text())
	_handle_planet_event(2, event)


func _on_planet_gas_input_event(camera, event, position, normal, shape_idx):
	print('gas planet click')
	_handle_planet_event(-1, event)


func _on_planet_3_input_event(camera, event, position, normal, shape_idx):
	_handle_planet_event(3, event)


func _handle_planet_event(planet: int, event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			show_planet_info(planet) 

func show_planet_info(_planet: int):
	var planet = Planet.get_planet(_planet)
	
	if planet == null:
		# Gas
		if _planet == -1:
			planet = {
				'name': 'Talanos',
				'description': 'Gaseoso',
				'motor_lvl': 999,
				'cost': {}
			}
			
	print('planet', planet)

	$PlanetInfoPanel/VBoxContainer/NameLabel.text = planet.name
	$PlanetInfoPanel/VBoxContainer/DesciptionLabel.text = planet.description
	$PlanetInfoPanel/VBoxContainer/MotorContainer/LevelNumberLabel.text = String.num_int64(planet.motor_lvl)
	
	var costs_text = ""
	for cost in planet.cost.keys():
		costs_text += "◆ " + String.num_int64(planet.cost[cost]) + "/" + String.num_int64(Inventory.inventory[cost]) + " " + cost + "\n"
	$PlanetInfoPanel/VBoxContainer/CostsContainer/Label.text = costs_text
	
	#if not Planet.can_travel_to(planet):
		#$PlanetInfoPanel/VBoxContainer/Actions/Travel.theme.add_theme_font_override()
	
	$PlanetInfoPanel.visible = true
	$PlanetInfoPanel.grab_focus()
