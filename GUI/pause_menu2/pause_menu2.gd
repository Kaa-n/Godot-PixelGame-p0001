extends CanvasLayer

signal shown
signal hidden

@onready var audio_stream_player: AudioStreamPlayer = $Control/AudioStreamPlayer
@onready var item_descripsion: Label = $Control/ItemDescripsion

var is_paused : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_pause_menu()
	
	pass # Replace with function body.


#mengambil input
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
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
	shown.emit()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	hidden.emit()
		
		
	
func update_item_description(new_text : String) -> void:
	item_descripsion.text = new_text
	
	
	
func play_audio(audio : AudioStream) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
	
	
