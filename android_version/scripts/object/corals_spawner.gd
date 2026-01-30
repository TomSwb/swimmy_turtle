extends Node2D

@onready var main: Control = $"../.."
@onready var sfx_score: AudioStreamPlayer2D = $"../../sfx_score"
@onready var game_over_menu: GameOverMenu = $"../../game_over_menu"

var corals: = preload("res://scenes/object/corals.tscn")
var score := 0
var best_score := 0

const SAVE_PATH := "user://save.dat"
# max bottom y = 152.0
# max top y = -232.0
	
func _on_timer_timeout() -> void:
	var spawning_corals = corals.instantiate()
	spawning_corals.position.y = randi_range(-200, 120)
	spawning_corals.update_score.connect(add_score)
	add_child(spawning_corals)
	load_best_score()
	game_over_menu.set_best_score(best_score)
	
	
func add_score() -> void:
	score += 1
	main.scored(score)
	game_over_menu.set_final_score(score)
	
	if score > best_score:
		best_score = score
		save_best_score()

	game_over_menu.set_best_score(best_score)
	sfx_score.play()
	
func save_best_score():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(best_score)

func load_best_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		best_score = file.get_var()
