class_name HpRegen extends Node

@onready var player: Player = $".."
var hp_regen : bool = false

#PENAMBAHAN HP DARI ENERGI

func _process(delta: float) -> void:
	if player.fp > 5 && player.hp < 10 && hp_regen == false:
		hp_regen = true
		await get_tree().create_timer(2).timeout
		_regen_on()
		
	
	

func _regen_on() -> void:
	
	player.update_fp(-1)
	player.update_hp(2)
	
	await get_tree().create_timer(5).timeout

	if player.fp > 5 && player.hp < 10:
		_regen_on()
	else:
		hp_regen = false
