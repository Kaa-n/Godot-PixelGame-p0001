class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
#ekspor rentang garis bawah
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var idle: State_Idle = $"../Idle"
@onready var hurt_box: HurtBox = $"../../Interaction/HurtBox"



func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim.play( "attack_" + player.AnimDirection() )
#	sinyal untuk animasi setelah diputar, menghubungkan kode untuk fungsi serangan akhir
	animation_player.animation_finished.connect( EndAttack)
	audio.stream = attack_sound
	#nada rendah-tinggi, random
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	attacking = true
#	jeda
	await get_tree().create_timer(0.075).timeout
#	mengaktifkan monitoring sehingga pada hurtbox
	if attacking:
		hurt_box.monitoring = true
	pass
	
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass
	
func Process( _delta : float ) -> State:
#	player tetap bergerak saat menyerang
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
#		Jika vektor bukan 0
		return walk
		
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null


func EndAttack( _newAnimName) -> void:
	attacking = false
