extends RichTextLabel

enum ControlType { KEYBOARD, JOYSTICK, MOBILE }

var control_type = ControlType.KEYBOARD

func _ready() -> void:
	_update_tutorial_text()
	

func _update_tutorial_text() -> void:
	match control_type:
		ControlType.KEYBOARD:
			self.bbcode_text = """
			[b]Tutorial Controls[/b]
			- Use [color=yellow]W, A, S, D[/color] to move.
			- Hold [color=orange]Shift[/color] to sprint.
			- Press [color=lightblue]Space[/color] to jump.
			"""
		ControlType.JOYSTICK:
			self.bbcode_text = """
			[b]Tutorial Controls[/b]
			- Use [color=yellow]Left Stick[/color] to move.
			- Hold [color=orange]Right Trigger[/color] to sprint.
			- Press [color=lightblue]A Button[/color] to jump.
			"""
		ControlType.MOBILE:
			self.bbcode_text = """
			[b]Tutorial Controls[/b]
			- Use the [color=yellow]on-screen joystick[/color] to move.
			- Hold the [color=orange]sprint button[/color] to sprint.
			- Tap the [color=lightblue]jump button[/color] to jump.
			"""
			

func _input(event):
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		if control_type != ControlType.JOYSTICK:
			control_type = ControlType.JOYSTICK
			_update_tutorial_text()
	elif event is InputEventScreenTouch or event is InputEventScreenDrag:
		if control_type != ControlType.MOBILE:
			control_type = ControlType.MOBILE
			_update_tutorial_text()
	elif event is InputEventKey:
		if control_type != ControlType.KEYBOARD:
			control_type = ControlType.KEYBOARD
			_update_tutorial_text()
