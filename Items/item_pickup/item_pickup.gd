@tool
class_name ItemPickup extends CharacterBody2D

@export var item_data : ItemData : set = _set_item_data

signal picked_up

@onready var item_area: Area2D = $ItemArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():#execute code only editor
		return 
	#execute code only in game
	item_area.body_entered.connect( _on_body_entered)
	# collision mask dari ItemArea harus sama dengan collision mask player

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * 4

func _on_body_entered(b) -> void:
	#b itu body
	if b is Player: #jika body tersebut adalah Player
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()
	pass
	
func item_picked_up() -> void:
	print("ha")
	item_area.body_entered.disconnect( _on_body_entered)
	audio_stream_player_2d.play()
	visible = false
	picked_up.emit() #signal picked up dikirim
	await audio_stream_player_2d.finished
	queue_free() #ItemPickup dihapus dari scene
	pass


func _set_item_data( value : ItemData ) -> void:
	item_data = value
	_update_texture()
	pass 
	
func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
