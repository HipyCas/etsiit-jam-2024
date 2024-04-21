extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_dismiss_pressed():
	self.visible = false


func _on_travel_pressed():
	Planet.goto_planet(self.get_meta("planet_idx"))
