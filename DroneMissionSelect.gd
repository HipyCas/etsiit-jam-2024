extends Control


const DRONE_MISSION_SCENE = preload("res://DroneMissionItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MissionOngoing.visible = DroneManager.mission_ongoing()
	$ScrollContainer.visible = not DroneManager.mission_ongoing()
	
	for idx in range(len(DroneManager.daily_missions)):
		render_mission($ScrollContainer/VBoxContainer, idx)


func _process(delta):
	$MissionOngoing.visible = DroneManager.mission_ongoing()
	$ScrollContainer.visible = not DroneManager.mission_ongoing()


func render_mission(parent: Node, mission_idx: int):
	var mission_scene = DRONE_MISSION_SCENE.instantiate()
	
	mission_scene.set_meta('missionidx', mission_idx)
	
	parent.add_child(mission_scene)
