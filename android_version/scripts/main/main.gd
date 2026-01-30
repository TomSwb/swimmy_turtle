extends Control

@onready var turtle: Area2D = $turtle # import the turtle

# imports scoring labels
@onready var score_label: Label = $Labels/score_label 
@onready var starting_timer_label: Label = $Labels/starting_timer_label

# imports background elements
@onready var sea: ParallaxBackground = $background/sea
@onready var floor: ParallaxBackground = $background/floor

@onready var sfx_score: AudioStreamPlayer2D = $sfx_score
@onready var corals_spawner_timer: Timer = $corals/corals_spawner/Timer 
@onready var game_over_menu: Control = $game_over_menu

var game_running : bool

func _ready() -> void:
	await start_countdown()
	start_game()
	
func start_countdown() -> void:
	for i in range(3, 0, -1):
		starting_timer_label.text = str(i)
		sfx_score.pitch_scale = 1.8
		sfx_score.play()
		await get_tree().create_timer(1.0).timeout

	sfx_score.pitch_scale = 2.6
	sfx_score.play()
	starting_timer_label.text = "GO!"
	await get_tree().create_timer(0.5).timeout
	starting_timer_label.hide()
	sfx_score.pitch_scale = 1.0
	
func start_game():
	game_running = true
	score_label.show()
	turtle.turtle_move(true)
	corals_spawner_timer.start()
	
func scored(score_value: int) -> void:
	score_label.text = str(score_value)

# called when turtle game_over signal is emited due to entering a coral colission zone
func _on_game_over() -> void:
	
	# stops corals and their spawning
	corals_spawner_timer.stop()
	get_tree().call_group("corals" , "stop_moving") # since corals are not in the tree they are in a group that we stop calling the function "stop_moving from their script
	
	# calls the stop scrolling functions in both background elements
	floor.floor_stop_moving(false)
	sea.sea_stop_moving(false)
	
	# stop turtle
	turtle.turtle_move(false)
	
	# hides score label
	score_label.hide()

	# shows game over menu
	await get_tree().create_timer(1.5).timeout # small timeout before game over shows
	game_over_menu.show()
	
	
	
