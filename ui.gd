extends CanvasLayer

class_name ui
signal game_started
var game_points=0

@onready var end_of_game_screen = $end_of_game_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_points(time_played: int):
	points = time_played

func on_game_over():
	end_of_gane_screen.visible = true
	$end_of_game_screen/end_game_scoreDisplay/points.text = "%d" % game_points

func _on_restart_button_pressed():
	get_tree().reload_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




