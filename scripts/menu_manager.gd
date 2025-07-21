extends Node
@onready var main_menu: ColorRect = $MainMenu
@onready var settings_menu: ColorRect = $SettingsMenu

func _ready() -> void:
	settings_menu.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true
	settings_menu.get_node("PanelContainer/Settings/EngineSlider").grab_focus()
	

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_visibility_changed() -> void:
	get_tree()
