class_name OptionMenu
extends Control

@onready var back_button: Button = $back_button as Button

signal back_to_main_menu

func _ready():
	back_button.button_up.connect(on_back_up)
	set_process(false)
	
func on_back_up():
	back_to_main_menu.emit()
	set_process(false)
	 
