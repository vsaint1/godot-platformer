extends Area2D

@export var coin_pick_sound: AudioStreamPlayer2D = null

func _on_body_entered(body: Node2D) -> void:
	self.visible = false
	coin_pick_sound.play()
	
	await coin_pick_sound.finished
	
	self.queue_free()
	
	
