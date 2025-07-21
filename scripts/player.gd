extends CharacterBody2D

const SPRINT_SPEED := 130.0

var speed := 75.0
var jump_velocity := -(speed * 4)
var jumped := false

@export var mobile_control: Control = null

func _ready() -> void:
	
	if !InteractionManager.is_mobile():
		mobile_control.queue_free()
	

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		jumped = true

	if is_on_floor() && jumped:
		velocity.y = jump_velocity
		jumped = false

	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = 75.0

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
