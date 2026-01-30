extends CharacterBody2D

@onready var top_coral: CharacterBody2D = $top_coral
@onready var bottom_coral: CharacterBody2D = $bottom_coral

signal update_score
const SPEED = -100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(SPEED, 0)

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func _on_screen_exited() -> void:
	disable_shape(top_coral)
	disable_shape(bottom_coral)
	queue_free()
	
func disable_shape(shape: Node) -> void:
	shape.set_deferred("disabled", true)

func _on_score_area_area_exited(_area: Area2D) -> void:
		update_score.emit()
		
func stop_moving() -> void:
	set_physics_process(false)
