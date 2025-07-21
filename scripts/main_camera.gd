extends Camera2D

@export var map: TileMapLayer = null

func _ready() -> void:

	var map_size = map.get_used_rect()
	var cell_size = map.tile_set.tile_size

	self.limit_left = map_size.position.x * cell_size.x
	self.limit_top = map_size.position.y * cell_size.y
	self.limit_right = (map_size.position.x + map_size.size.x) * cell_size.x
	self.limit_bottom = (map_size.position.y + map_size.size.y) * cell_size.y
	
