extends Node

const PLAYER = preload("res://player/player.tscn")
const INVENTORY_DATA : InventoryData = preload(
	"res://GUI/pause_menu2/inventory/player_inventory.tres")

signal interact_pressed

var player : Player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.5).timeout
	player_spawned = true
	

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass
	
func set_health(hp: int, max_hp: int) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp(0)
	
func set_hunger(fp: int, max_fp: int) -> void:
	player.max_fp = max_fp
	player.fp = fp
	player.update_fp(0)
	
func set_player_position( _new_pos : Vector2 ) -> void:
	player.global_position = _new_pos
	pass
	
func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
func unparent_player(_p : Node2D) -> void:
	_p.remove_child(player)
