extends ParallaxBackground


@onready var floor_texture: Sprite2D = $floor/sprite2D # loads floor sprite
const scrol_speed = 100 # sets scrolling speed, higher = faster

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	floor_texture.texture = load ("res://assets/sprites/floor.png") # if adding more background option can use this with randi_range and generic path

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x -= scrol_speed * delta # creates the scrolling effect toward the left, use += for toward right

func floor_stop_moving(_value: bool) -> void:
	set_process(false)
	
	
