class_name GameOverMenu
extends Control

@onready var restart_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/restart_button
@onready var menu_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/menu_button
@onready var final_score_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/final_score
@onready var best_score_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/best_score

func _ready():
	restart_button.pressed.connect(on_restart_up)
	menu_button.pressed.connect(on_menu_up)

func on_restart_up():
	get_tree().change_scene_to_file("res://scenes/main_screen/main.tscn")

func on_menu_up():
	get_tree().change_scene_to_file("res://scenes/user_interface/main_menu.tscn")

func set_final_score(score_value: int) -> void:
	final_score_label.text = "Final Score: " + str(score_value)

func set_best_score(value: int) -> void:
	best_score_label.text = "Best Score: " + str(value)
