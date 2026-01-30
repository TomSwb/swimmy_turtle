extends CharacterBody2D

const GRAVITY : int = 1000 # how quickly turtle drop
const MAX_VEL : int = 600 # max fall speed
const SWIMM_SPEED : int = -500 # how much turtle swimm up
var swimming : bool = false # flag active until turtle touch ostacle
var dying : bool = false # becomes active when touching obstacle and falls to ground
const START_POS = Vector2(100, 400) # defines starting coordinates


# called when game is opened
func _ready():
	reset()
	
func reset():
	dying = false
	swimming = false
	position = START_POS
	$AnimateSprite2D.play("idle")
	set_rotation(0)

# handle all turtle movements
# called every frame, "delta" is the elapsed time since the previous frame
func _physics_process(delta):
	# Apply gravity if the turtle is swimming or dying
	if swimming or dying:
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		# Move and detect collisions with the ground
		move_and_slide()
		
		# Handle animations
		if swimming:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimateSprite2D.play("swimming")
		elif dying:
			set_rotation(0)
			$AnimateSprite2D.play("dying")

func swimm():
	velocity.y = SWIMM_SPEED
