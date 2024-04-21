extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var mission = DroneManager.daily_missions[self.get_meta("missionidx")]
	
	$PaddingWrapper/MainLayout/Header/Coords.text = "[" + String.num_int64(mission.coords[0]) + ", " + String.num_int64(mission.coords[1]) + "]"
	$PaddingWrapper/MainLayout/Header/Duration.text = String.num_int64(mission.mission_length_ingame_hours) + "h"
	
	for cond in mission['conds'].keys():
		var lbl = Label.new()
		lbl.text = '◆  ' + cond
		$PaddingWrapper/MainLayout/Conditions.add_child(lbl)
		
	#$Label.text = JSON.stringify(mission)


func _on_button_pressed():
	DroneManager.lauch_mission(self.get_meta("missionidx"))
