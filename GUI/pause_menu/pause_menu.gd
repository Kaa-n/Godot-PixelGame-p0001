extends CanvasLayer

@onready var button_save: Button = $VBoxContainer/Button_Save
@onready var button_quit: Button = $VBoxContainer/Button_Quit

const LOBBY : String = "res://TitleScene/title_scene.tscn"

var is_paused : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect( _on_save_pressed)
	button_quit.pressed.connect( _on_quit_pressed)
	pass # Replace with function body.


#mengambil input
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
#			call(pemanggilan)
			show_pause_menu()
		else:
			hide_pause_menu()
			
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
		
		

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass

func _on_quit_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	AreaManager.load_new_level(LOBBY, "", Vector2.ZERO)
	
	#await LevelManager.level_load_started
	
	
	pass
