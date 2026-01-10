extends Node2D

const START_LEVEL : String = "res://Area/Area01/01.tscn"

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_press_audio : AudioStream



@onready var button_new: Button = $CanvasLayer/Control/ButtonNew
@onready var button_continue: Button = $CanvasLayer/Control/ButtonContinue


func _ready() -> void:
	get_tree().paused = true
	
	PlayerManager.player.visible = false
	
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED
	PauseMenu2.process_mode = Node.PROCESS_MODE_DISABLED
	
	if SaveManager.get_save_file() == null:
		button_continue.disabled = true
		button_continue.visible = false
	
	
	setup_title_screen()
	
	AreaManager.level_load_started.connect(exit_title_screen)
	pass 

func setup_title_screen() -> void:
	#AudioManager.play_music(music)
	
	#process harus dalam mode always, jika tidak: tombol tak berfungsi
	button_new.pressed.connect( start_game )
	button_continue.pressed.connect( load_game )

	button_new.grab_focus()
	
	button_new.focus_entered.connect(play_audio.bind(button_focus_audio))
	button_continue.focus_entered.connect(play_audio.bind(button_focus_audio))
	
	pass

func start_game() -> void:
	#play_audio(button_press_audio)
	
	SaveManager.reset_game()

func load_game() -> void:
	#play_audio(button_press_audio)
	SaveManager.load_game()
	
func exit_title_screen() -> void:
	
	PlayerManager.player.visible = true
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	PauseMenu2.process_mode = Node.PROCESS_MODE_ALWAYS
	self.queue_free()


func play_audio(_a : AudioStream) -> void:
	#audio_stream_player.stream = _a
	#audio_stream_player.play()
	pass
