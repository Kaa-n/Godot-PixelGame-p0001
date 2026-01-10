class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.Damaged.connect(TakeDamage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func TakeDamage(damage : int) -> void:
#	untuk menghapus sesuatu dari game
	queue_free()
	pass
