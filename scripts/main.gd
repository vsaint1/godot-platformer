extends Node2D
enum Difficulty {
	NOVICE = 0,
	EASY,
	MEDIUM,
	HARD
}	

var level_difficulty: Difficulty = Difficulty.NOVICE




func _on_killzone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
