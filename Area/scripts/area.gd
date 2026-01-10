class_name Area extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	AreaManager.level_load_started.connect(_free_level)
	AreaManager.reset.connect(_on_reset)

func _free_level() -> void:
	PlayerManager.unparent_player(self)
	queue_free()

func _on_reset() -> void:
	get_tree().reload_current_scene()
	pass

func _stop() -> void:
	get_tree().paused = true
	
func _start() -> void:
	get_tree().paused = false
