extends Area2D

@onready var text_label := $RichTextLabel
@export var text := "Hi!"
var can_interact := false

func _ready():
	text_label.bbcode_enabled = true
	text_label.visible = false
	text_label.clear()

func _on_body_entered(_body: Node2D):
	can_interact = true
	text_label.visible = true
	
	show_interaction_message()

func _on_body_exited(_body: Node2D):
	can_interact = false
	text_label.visible = false
	text_label.clear()

func _unhandled_input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("interact"):
		text_label.clear()
		text_label.append_text(text.replace("\n", "[br]"))
		await get_tree().create_timer(5).timeout
		show_interaction_message()

func show_interaction_message():
	text_label.clear()

	var gesture = tr("TEXT_GESTURE_TAP") if InteractionManager.is_mobile() else tr("TEXT_GESTURE_PRESS")
	
	text_label.add_text(gesture)
	text_label.add_image(InteractionManager.get_input_icon())
	text_label.add_text(tr("TEXT_INTERACT"))
