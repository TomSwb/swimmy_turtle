class_name MainMenu
extends Control

@onready var start_button: Button = $container/start_button
@onready var options_button: Button = $container/options_button
@onready var quit_button: Button = $container/quit_button 
@onready var option_menu: OptionMenu = $option_menu
@onready var container: Control = $container


@onready var start_game = preload("res://scenes/main.tscn") as PackedScene

func _ready():
	handle_connecting_signals()
	
func on_start_up():
	get_tree().change_scene_to_packed(start_game)
		
func on_option_up():
	container.visible = false
	option_menu.set_process(true)
	option_menu.visible = true
	
func on_back_main_menu():
	option_menu.visible = false
	container.visible = true

func on_quit_up():
	get_tree().quit()

func handle_connecting_signals():
	start_button.button_up.connect(on_start_up)
	options_button.button_up.connect(on_option_up)
	quit_button.button_up.connect(on_quit_up)
	option_menu.back_to_main_menu.connect(on_back_main_menu)
