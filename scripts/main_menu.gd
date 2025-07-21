extends ColorRect

func _on_start_pressed() -> void:
	print("staring game")
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")
	
	
