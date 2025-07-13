extends CharacterBody2D

const SPEED = 75.0

const JUMP_VELOCITY = -(SPEED * 4) 


func _physics_process(delta: float) -> void:
	
	if (!is_on_floor()):
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
