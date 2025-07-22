extends Area2D

@export var coin_pick_sound: AudioStreamPlayer2D = null

var already_collected := false

func _on_body_entered(body: Node2D) -> void:
	
	if already_collected:
		return
		
	already_collected = true
	
	var amount = randi() % 5 + 1
	
	# since only the player can collide its safe to do this
	body.add_coin(amount)
	
	self.visible = false
	coin_pick_sound.play()
	
	await coin_pick_sound.finished
	
	self.queue_free()
	
	
