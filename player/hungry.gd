class_name Hungry extends Node

@onready var player: Player = $".."
var hungry_effect : bool = false


#EFEK LAPAR


func _process(delta: float) -> void:
	if player.fp < 1 && player.hp > 1 && hungry_effect == false:
		hungry_effect = true
		await get_tree().create_timer(5).timeout
		_hungry_on()
		
	
	

func _hungry_on() -> void:
	
	
	player.update_hp(-1)
	await get_tree().create_timer(10).timeout

	if player.fp < 1 && player.hp > 1:
		_hungry_on()
	else:
		hungry_effect = false
