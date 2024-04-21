extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$Content/days_elapsed.text='Has sobrevivido ' + str(GameTime.days_elapsed) + ' días'
