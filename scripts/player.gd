extends CharacterBody2D

const SPRINT_SPEED := 130.0
const WALK_SPEED := 75.0

var health := 100
var speed := 75.0
var jump_velocity := -(speed * 4)
var jumped := false
var coins: int = 0
var bottles: int = 0
var is_dead := false

@export var mobile_control: Control = null
@export var animation: AnimatedSprite2D = null
@export var user_interface: HBoxContainer= null

var coin_label: Label = null
 
func _ready() -> void:
	coin_label = user_interface.get_node("CoinCount")
	
	_setup_mobile_gameplay()
		


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if is_dead:
		velocity = Vector2.ZERO
		animation.play("DYING")
		return

	if !is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		jumped = true

	if  is_on_floor() && jumped:
		velocity.y = jump_velocity
		jumped = false
		animation.play("JUMP")

	speed = SPRINT_SPEED if InteractionManager.is_mobile() || Input.is_action_pressed("sprint") else WALK_SPEED

	
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		velocity.x = direction * speed
		animation.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if is_on_floor():
		if abs(velocity.x) > 0.1:
			animation.play("RUNNING")
		else:
			animation.play("IDLE")

	move_and_slide()

func _setup_mobile_gameplay() -> void:
	if !InteractionManager.is_mobile():
		mobile_control.queue_free()
		return
	
func add_coin(amount: int = 1) -> void:
	coins += amount
	coin_label.text = str(coins)

func hurt(damage: int = 1) -> void:
	health -= damage
	
	if health <=0:
		is_dead = true
		
	print(health)
