class_name  ItemEffectEat extends ItemEffect



@export var eat_amount : int = 1
@export var audio : AudioStream


func use() -> void:

	PlayerManager.player.update_fp(eat_amount)
	PauseMenu2.play_audio(audio)
	
