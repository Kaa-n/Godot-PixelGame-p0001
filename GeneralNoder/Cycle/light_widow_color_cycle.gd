extends PointLight2D

const MinutePerDay = 1440
const MinuteperHour = 60
const Ingame_to_real_minute_duration = (2 * PI) / MinutePerDay

@export var gradient:GradientTexture1D
@export var IngameSpeed = 1.0
@export var InitialHour = 12:
	set(h):
		InitialHour = h
		time = Ingame_to_real_minute_duration * InitialHour * MinuteperHour

var time: float = 0.0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = Ingame_to_real_minute_duration * InitialHour * MinuteperHour
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.time += delta * Ingame_to_real_minute_duration * IngameSpeed
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	

	
	
	
	
