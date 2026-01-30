extends ParallaxBackground


@onready var sea: Sprite2D = $sea/sprite2D # loads sky sprite
const scrol_speed = 100 # sets scrolling speed, higher = faster

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sea.texture = load ("res://assets/sprites/sea.png") # if adding more background option can use this with randi_range and generic path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x -= scrol_speed * delta # creates the scrolling effect toward the left, use += for toward right

	

# stops the scrolling of the sea
func sea_stop_moving(_value: bool) -> void:
	set_process(false)
