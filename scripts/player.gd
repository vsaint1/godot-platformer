extends CharacterBody2D

const SPRINT_SPEED := 250.0
const WALK_SPEED := 75.0

var health := 100
var speed := WALK_SPEED
var jump_velocity := -300.0
var jumped := false
var coins := 0
var bottles := 0
var is_dead := false

@export var mobile_control: Control = null
@export var animation: AnimatedSprite2D = null
@export var user_interface: HBoxContainer = null
@export var health_bar: ProgressBar = null
@export var hurt_sound: AudioStreamPlayer2D = null

var coin_label: Label = null

func _ready() -> void:
	coin_label = user_interface.get_node("CoinCount")
	_setup_mobile_gameplay()
	health_bar.value = health
	

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	apply_gravity(delta)
	handle_input()
	handle_movement(delta)
	handle_animation()
	move_and_slide()

func _setup_mobile_gameplay() -> void:
	if not InteractionManager.is_mobile():
		mobile_control.queue_free()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jumped = true

	if is_on_floor() and jumped:
		velocity.y = jump_velocity
		jumped = false
		animation.play("JUMP")

	speed = SPRINT_SPEED if InteractionManager.is_mobile() or Input.is_action_pressed("sprint") else WALK_SPEED

func handle_movement(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * speed
		animation.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func handle_animation() -> void:
	if is_on_floor():
		if abs(velocity.x) > 0.1:
			animation.play("RUNNING")
		else:
			animation.play("IDLE")

func add_coin(amount: int = 1) -> void:
	coins += amount
	coin_label.text = str(coins)

func hurt(damage: int = 1) -> void:
	if is_dead:
		return

	health -= damage
	
	health_bar.value = health
	hurt_sound.play()
	
	if health <= 0:
		die()

func die() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	animation.play("DYING")

	await get_tree().create_timer(2.0).timeout  
	get_tree().reload_current_scene()
