extends Timer

@onready var player: Player = $".."

#PENGIKISAN ENERGI / RASA LAPAR

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if player.timer_on == true:
		player.time += delta
		if player.time >= 15:
			if player.fp > 0:
				player.update_fp(-1)
			player.time = 0
	pass


	
