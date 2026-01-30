extends Node

# export coral scene through code instead of adding it manually
@export var coral_scene : PackedScene 
@onready var sfx_score: AudioStreamPlayer2D = $sfx_score

# flags to determine game state
var game_running : bool
var game_over : bool

var scroll # use to move the image accross the screen smoothly
var score # tracks progress
const SCROLL_SPEED : int = 3 # to adjust scrolling speed
var screen_size : Vector2i # init size of screen var
var ground_height : int # inti height of ground var
var corals : Array # stores all the corals that we create
# control corals generation
const CORAL_DELAY : int = 150
const CORAL_RANGE : int = 200

# called when game is opened or restarted
func _ready():
	screen_size = get_window().size # get the size of the game window
	ground_height = $ground.get_node("Sprite2D").texture.get_height() # gets height of the ground
	new_game()
	
func new_game():
	# resets all variables of game and player
	game_running = false
	game_over = false
	$game_over.hide()
	get_tree().call_group("corals", "queue_free")
	score = 0
	$score_label.text = str(score)
	scroll = 0
	corals.clear()
	# generates starting corals and player
	generate_corals()
	$turtle.reset()
	
# manages player inputs - both beginning of game and playing
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton: # turtle stationary until mouse click
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				if game_running == false:
					start_game()
				else:
					if $turtle.swimming:
						$turtle.swimm()
						check_top()

func start_game():
	game_running = true
	$turtle.swimming = true
	$turtle.swimm()
	# starts corals timer
	$coral_timer.start()

# generate the scrolling effect of the ground
# called every frame, "delta" is the elapsed time since the previous frame
func _process(delta):
	if game_running:
		scroll += SCROLL_SPEED # begin scrolling
		# reset scroll
		if scroll >= screen_size.x:
			scroll = 0
		# move ground node
		$ground.position.x = -scroll
		# move corals
		for coral in corals:
			coral.position.x -= SCROLL_SPEED

# generates the corals inside the game
func _on_coral_timer_timeout():
	generate_corals()
	
# create the corals generationa nd randomization
func generate_corals():
	var coral = coral_scene.instantiate()
	coral.position.x = screen_size.x + CORAL_DELAY # generates the corals on the right side of screen without out of fin air effect
	coral.position.y = (screen_size.y - ground_height) / 2 + randi_range(-CORAL_RANGE, CORAL_RANGE) # generates the corals at random height keeping the range
	coral.hit.connect(turtle_hit)
	coral.scored.connect(scored)
	add_child(coral)
	corals.append(coral)
	
func scored():
		score += 1
		$score_label.text = str(score)
		sfx_score.play()

func check_top():
	if $turtle.position.y < 0:
		$turtle.dying = true
		stop_game()

func turtle_hit():
	$turtle.dying = true
	stop_game()
	
func _on_ground_hit():
	$turtle.dying = false
	$turtle/AnimateSprite2D.play("dying")
	stop_game()

func stop_game():
	game_over = true
	$coral_timer.stop()
	$turtle.swimming = false
	game_running = false
	await get_tree().create_timer(1.5).timeout # small timeout before game over shows
	# guards game over screen to show multiple times
	if game_over:
		$game_over.show()
	

func _on_game_over_restart():
	new_game()
