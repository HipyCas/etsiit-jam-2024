extends Control
signal start_game_pressed

@onready var start_game_button: Button = $%StartGameButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 

func _ready():
	#start_game_button.grab_focus()
	pass

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()

func _on_start_game_button_pressed():
	emit_signal("start_game_pressed")
	
	print("Game Started")
	get_tree().change_scene_to_file("res://main_starship.tscn")
	
