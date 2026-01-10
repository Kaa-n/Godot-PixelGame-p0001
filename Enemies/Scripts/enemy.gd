class_name Enemy extends CharacterBody2D

signal DirectionChanged(new_direction : Vector2)
signal enemy_damaged(hurt_box : HurtBox)
signal enemy_destroyed(hurt_box : HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 5

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
#kebal atau tidak
var invulnerable : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var idle: Sprite2D = $idle
#@onready var walk: Sprite2D = $walk
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: HitBox = $HitBox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta):
	move_and_slide()
	
	
func set_direction( _new_direction : Vector2) -> bool:
	direction = _new_direction
	#var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
#	round: pembulatan, angle: sudut
	var direction_id : int = int( round( 
		( direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size() 
	))
#	nilai anatara 0 sampai 3
	
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
#	untuk membalik karakter jika ke kiri
	animated_sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	#idle.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	#walk.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation( state : String) -> void:
	animation_player.play( state + "_" + anim_direction())
	#animated_sprite_2d.play( state + "_" + anim_direction())
	pass

#arah animasi
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"



func _take_damage(hurt_box : HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		enemy_damaged.emit(hurt_box)
	else:
		enemy_destroyed.emit(hurt_box)
