extends Area2D

@onready var animation_sprite: AnimatedSprite2D = $AnimatedSprite2D # import the sprite animations
@onready var animation_player: AnimationPlayer = $AnimationPlayer # import the animation player
@onready var score_area: Area2D = $score_area # imports scoring node
@onready var START_POS := position # defines starting coordinates

var velocity: Vector2 = Vector2.ZERO # sets velocity

const SWIMM_VELOCITY = -200.0 # define turtle speed
# const ROTATION_SPEED = 200.0 # sets the rotation speed

signal game_over # initiate game over signal

func _ready() -> void:
	reset()
	
func reset() -> void:
	gravity = 500.0 # set gravity (speed turtles goes up or down
	position = START_POS # applies starting position
	animation_player.play("up_&_down")
	animation_sprite.play("idle")
	turtle_move(false)

# manages the turtle physics
func _process(delta: float) -> void:
	velocity.y += gravity * delta # applies gravity down
	
	# applies rotations
	# if rotation_degrees <= 15.0 and velocity.y > 0: # checks rotation upward
		# rotation_degrees += ROTATION_SPEED * delta # applies downwatd rotation
	# else:
		# if rotation_degrees >= -15.0: # check rotation downward
			# rotation_degrees -= ROTATION_SPEED * delta # applies upward rotation
		
	# applies the swimming animation when control is pressed and get the turtle going up and down
	if Input.is_action_just_pressed("swimm"): 
		velocity.y = SWIMM_VELOCITY # makes the turtle swimm up
		animation_sprite.play("swimming") # plays the swimming animation
		
	position += velocity * delta # applies jump gravity effect

# checks if player enters another body (corals, ground, ceilling) and swap to dead animation and triggers game_over

func _on_body_entered(_body: Node2D) -> void:
	if !score_area:
		# set_rotation(0)
		animation_player.stop()
		animation_sprite.play("dying") # play dying animation 
		game_over.emit() # emit the game_over signal to change game state
		
	
	# stop the turtle movements on screen
func turtle_move(value: bool) -> void:
	set_process(value)
	
