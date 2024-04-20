extends CanvasLayer

var points = 0

func _ready():
	game_state = Gamestate.IDLE
	#.game_started.connect(game_started)
	#.crashed.connect(end_game)

func game_started():
	game_state = GameState.RUNNING
	pipe_spawner.start_spawning()

func end_game():
	#pipe_spawner.stop();
	ui.on_game_over().

func point_scored():
	points += 1
	print(points)
