class_name GameOver
extends Control

@onready var restart_button: Button = $restart_button
@onready var menu_button: Button = $menu_button 

signal restart
signal main_menu

func _ready():
	restart_button.button_up.connect(on_restart_up)
	menu_button.button_up.connect(on_menu_up)
	
func on_restart_up():
	restart.emit()
	
func on_menu_up():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
