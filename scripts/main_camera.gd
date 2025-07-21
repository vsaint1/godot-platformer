extends Camera2D

func _ready() -> void:
	var map := _find_map()

	if map:
		var map_size = map.get_used_rect()
		var cell_size = map.tile_set.tile_size

		limit_left = map_size.position.x * cell_size.x
		limit_top = map_size.position.y * cell_size.y
		limit_right = (map_size.position.x + map_size.size.x) * cell_size.x
		limit_bottom = (map_size.position.y + map_size.size.y) * cell_size.y
	else:
		push_error("TileMap not found!")

func _find_map() -> TileMap:
	var current = get_parent()
	while current:
		if current.has_node("Map"):
			var candidate = current.get_node("Map")
			if candidate is TileMap:
				return candidate
		current = current.get_parent()
	return null
