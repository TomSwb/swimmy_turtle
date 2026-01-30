class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/options_button
@onready var quit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/quit_button
@onready var margin_container: MarginContainer = $MarginContainer
@onready var options_menu: OptionsMenu = $options_menu
@onready var best_score_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/best_score_label

@onready var start_game = preload("res://scenes/main_screen/main.tscn") as PackedScene

const SAVE_PATH := "user://save.dat"

func _ready() -> void:
	handle_connecting_signals()
	load_best_score()
	
func on_start_up() -> void:
	get_tree().change_scene_to_packed(start_game)
	
func on_options_up() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	
func _on_options_menu_back_to_main_menu() -> void:
	options_menu.visible = false
	margin_container.visible = true
	
func on_quit_up() -> void:
	get_tree().quit()
	
func handle_connecting_signals() -> void:
	start_button.pressed.connect(self.on_start_up)
	options_button.pressed.connect(self.on_options_up)
	quit_button.pressed.connect(self.on_quit_up)
	
func load_best_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		best_score_label.text = "Best Score: " + str(file.get_var())
