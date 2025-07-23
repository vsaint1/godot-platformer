extends CharacterBody2D

@onready var ray_down: RayCast2D = $RayCast2D
@onready var sprite: Sprite2D = $Sprite2D

var speed = 40
var direction = -1
var damage = 0
var difficulty = 0

const TILE_SIZE = Vector2(32, 32)
const TOTAL_TILES = 4

func _ready():
	ray_down.enabled = true

	difficulty = GameManager.level_difficulty
	update_difficulty_stats()
	update_ray_position()
	setup_sprite_region()

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()

	if not ray_down.is_colliding() or is_on_wall():
		direction *= -1
		update_ray_position()
		sprite.scale.x = direction

func update_ray_position():
	ray_down.position.x = 8 * direction

func setup_sprite_region():
	sprite.region_enabled = true
	sprite.scale = Vector2(0.5,0.5)

	var tile_index = TOTAL_TILES - 1 - difficulty
	var columns = 2
	var col = tile_index % columns
	var row = tile_index / columns

	sprite.region_rect = Rect2(col * TILE_SIZE.x, row * TILE_SIZE.y, TILE_SIZE.x, TILE_SIZE.y)

func update_difficulty_stats():
	match difficulty:
		0:
			speed = 20
			damage = 5
		1:
			speed = 30
			damage = 10
		2:
			speed = 40
			damage = 15
		3:
			speed = 55
			damage = 25

func _on_area_2d_body_entered(body: Node) -> void:
	# safe since can only collide with player
	body.hurt(damage)
	
