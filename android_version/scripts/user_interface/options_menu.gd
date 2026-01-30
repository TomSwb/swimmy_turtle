class_name OptionsMenu
extends Control

@onready var back_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/back_button

signal back_to_main_menu

func _ready():
	back_button.pressed.connect(self.on_back_up)
	set_process(false)
	
func on_back_up():
	back_to_main_menu.emit()
	set_process(false)
