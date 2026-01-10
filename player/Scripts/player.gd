class_name Player extends CharacterBody2D

#signal direction_changed( new_direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

#array
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

# vvv tipe data vektor dua dimensi : (0,0)
var time = 0
var timer_on = false

var cardinal_direction : Vector2 = Vector2.DOWN #(0,1)
var direction : Vector2 = Vector2.ZERO

var invulnerable : bool = false

var hp : int = 10
var max_hp : int = 10

var fp : int = 10
var max_fp : int = 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox



#-------

#-------#


signal DirectionChanged( new_direction: Vector2)

# Called when the node enters the scene tree for the first time.
#dijalankan di awal game; 1 kali
func _ready():
	PlayerManager.player = self
	state_machine.Initialize(self)
	hit_box.Damaged.connect( _take_damage)
	update_hp(99)
	update_fp(99)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# dijalankan setiap kali sampai game berakhir
func _process(_delta):
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(_delta):
	move_and_slide()
	
	
func SetDirection() -> bool:
	#var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
#	round: pembulatan, angle: sudut
	var direction_id : int = int( round( 
		( direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size() 
	))
	print("dir: ", direction)
	print("car: ", cardinal_direction)
	print("tau: ", TAU)
	
	print("dirid: ", direction + cardinal_direction * 0.1)
	print("dirid+angle: ", (direction + cardinal_direction * 0.1).angle())
	print("dir_id---: ", direction_id)
#	nilai anatara 0 sampai 3
	var new_dir = DIR_4[direction_id]
	print("newdir: ", new_dir)
	
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir) #mengirim sinyal terhadap perubahan arah
	
#	untuk membalik karakter jika ke kiri
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
	
#memperbaharui animasi
func UpdateAnimation( state : String) -> void:
	animation_player.play( state + "_" + AnimDirection())
	pass

#arah animasi
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func _take_damage(hurt_box : HurtBox) -> void:
	if invulnerable == true:
		return
	
	if hp > 0:
		update_hp(-hurt_box.damage)
		player_damaged.emit(hurt_box)
	
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		update_hp(-99)
		player_damaged.emit($Interaction/HurtBox)
	pass

func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.update_hp(hp, max_hp)
	pass
	
func update_fp(delta: int) -> void:
	fp = clampi(fp + delta, 0, max_fp)
	PlayerHud.update_fp(fp, max_fp)
	pass
	
func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer( _duration).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass


func _on_timer_timeout() -> void:
	timer_on = true
	
	pass # Replace with function body.
	
func _on_on() -> void:
	#untuk melanjutkan pengurangan energi dari makanan
	timer_on = true
	
	
func _off_off() -> void:
	#untuk paused pengurangan energi gameover dan meriset timer
	timer_on = false
	time = 0
		
func revive_player() -> void:
	update_hp( 99 )
	state_machine.ChangeState( $StateMachine/Idle )
