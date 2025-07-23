extends Area2D

@export var message_label: Label = null  

func _ready() -> void:
	message_label.visible = false 

func _on_body_entered(body: Node2D) -> void:
	await handle_restart()

func handle_restart() -> void:
	message_label.visible = true
	
	await get_tree().create_timer(5.0).timeout
	
	get_tree().reload_current_scene()
