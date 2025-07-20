extends Node

const INPUT_ICONS := {
	"Mobile":{
		"atlas": "res://assets/ui/gdb/gdb-keyboard-2.png",
		"region": Rect2(448, 16, 16, 16)
	},
	"Xbox": {
		"atlas": "res://assets/ui/gdb/gdb-xbox-2.png",
		"region": Rect2(448, 32, 16, 16)
	},
	"PlayStation": {
		"atlas": "res://assets/ui/gdb/gdb-playstation-2.png",
		"region": Rect2(448, 32, 16, 16)
	},
	"Nintendo": {
		"atlas": "res://assets/ui/gdb/gdb-switch-2.png",
		"region": Rect2(448, 32, 16, 16)
	},
	"Keyboard": {
		"atlas": "res://assets/ui/gdb/gdb-keyboard-2.png",
		"region": Rect2(96, 48, 16, 16)
	},
}

func is_mobile() -> bool:
	var os = OS.get_name()
	
	if os == "Android" || os == "iOS":
		return true
	
	return false
	
func get_input_icon() -> AtlasTexture:
	if is_mobile():
		return _make_texture(INPUT_ICONS["Mobile"])
		
	var joypads = Input.get_connected_joypads()

	for joypad in joypads:
		var name = Input.get_joy_name(joypad).to_lower()
		if "xbox" in name:
			return _make_texture(INPUT_ICONS["Xbox"])
		elif "playstation" in name or "ps" in name:
			return _make_texture(INPUT_ICONS["PlayStation"])
		elif "nintendo" in name or "switch" in name:
			return _make_texture(INPUT_ICONS["Nintendo"])

	return _make_texture(INPUT_ICONS["Keyboard"])

func _make_texture(info: Dictionary) -> AtlasTexture:
	var tex := AtlasTexture.new()
	tex.atlas = load(info["atlas"])
	tex.region = info["region"]
	return tex
