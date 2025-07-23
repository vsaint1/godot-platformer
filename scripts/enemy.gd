extends CanvasLayer

@export var sprint_label: RichTextLabel = null

func _ready() -> void:
	if sprint_label:
		sprint_label.bbcode_text = """
		
		"""
