extends ColorRect


@export var resolution_label: Label = null
@export var resolution_option: OptionButton =null
@export var engine_slider: HSlider = null
@export var vsync: CheckBox = null
@export var start_menu_button: Button = null

var master_volume:float = 0.0

func _ready() -> void:
	var db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	master_volume = db_to_linear(db)
	engine_slider.value = master_volume
	var vsync_mode = ProjectSettings.get_setting("display/window/vsync/vsync_mode")
	vsync.button_pressed = vsync_mode
	
	if InteractionManager.is_mobile():
		resolution_label.queue_free()
		resolution_option.queue_free()


func _on_return_pressed() -> void:
	_return_to_main_menu()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_return_to_main_menu()

func _return_to_main_menu() -> void:
	self.visible = false
	var main_menu = get_parent().get_node("MainMenu")
	main_menu.visible = true
	start_menu_button.grab_focus()
	

func _on_engine_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_resolution_option_item_selected(index: int) -> void:
	
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		DisplayServer.window_set_size(Vector2i(1920,1080))
	
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1280,720))
		
	if index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(640,480))
			
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	var center_pos = (screen_size - window_size) / 2

	DisplayServer.window_set_position(center_pos)
	

func _on_vsync_toggled(toggled_on: bool) -> void:
	ProjectSettings.set_setting("display/window/vsync/vsync_mode",toggled_on)


func _on_language_option_item_selected(index: int) -> void:

	if index == 0:
		TranslationServer.set_locale("en_US")
	
	if index == 1:
		TranslationServer.set_locale("pt_BR")

	


func _on_difficulty_option_item_selected(index: int) -> void:
	GameManager.level_difficulty = index;
