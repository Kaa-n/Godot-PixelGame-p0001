extends CanvasLayer


#@export var button_focus_audio : AudioStream = preload(
	 #"res://title_scene/audio/menu_focus.wav" )
#@export var button_select_audio : AudioStream = preload(
	 #"res://title_scene/audio/menu_select.wav" )

var hearts : Array[HeartGUI] = []
var hungers : Array[HungerGUI] = []

@onready var game_over: Control = $Control/GameOver
@onready var new_button: Button = $Control/GameOver/VBoxContainer/NewButton
@onready var title_button: Button = $Control/GameOver/VBoxContainer/TitleButton
@onready var animation_player: AnimationPlayer = $Control/GameOver/AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer



# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	for child in $Control/HFlowContainer2.get_children():
		if child is HungerGUI:
			hungers.append(child)
			child.visible = false
	
	
	hide_game_over_screen()
	#new_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	new_button.pressed.connect( new_game )
	#title_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	title_button.pressed.connect( title_screen )
	AreaManager.level_load_started.connect( hide_game_over_screen )
	
	#hide_boss_health()
	
	pass # Replace with function body.

func update_hp(_hp: int, _max_hp: int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)
	pass
	
func update_fp(_fp: int, _max_fp: int) -> void:
	update_max_fp(_max_fp)
	for i in _max_fp:
		update_hunger(i, _fp)
	pass	

func update_heart(_index: int, _hp : int) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[_index].value = _value
	pass
	
func update_hunger(_index: int, _fp : int) -> void:
	var _value : int = clampi( _fp - _index * 2, 0, 2 )
	hungers[_index].value = _value
	pass
	
func update_max_hp(_max_hp : int) -> void:
	var _heart_count : int = roundi(_max_hp * 0.5)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
	
func update_max_fp(_max_fp : int) -> void:
	var _hunger_count : int = roundi(_max_fp * 0.5)
	for i in hungers.size():
		if i < _hunger_count:
			hungers[i].visible = true
		else:
			hungers[i].visible = false
	pass
	



func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color( 1,1,1,0 )


func show_game_over_screen() -> void:
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	
	
	animation_player.play("show_game_over")
	await animation_player.animation_finished
	
	
	new_button.grab_focus()
	
	


func new_game() -> void:
	#play_audio( button_select_audio )
	await fade_to_black()
	SaveManager.reset_game()
	

func title_screen() -> void:
	#play_audio( button_select_audio )
	await fade_to_black()
	AreaManager.load_new_level( "res://TitleScene/title_scene.tscn", "", Vector2.ZERO )


func fade_to_black() -> bool:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	PlayerManager.player.revive_player()
	return true


func play_audio( _a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()
