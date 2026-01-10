extends ColorRect

const MinutePerDay = 1440
const MinuteperHour = 60
const Ingame_to_real_minute_duration = (2 * PI) / MinutePerDay

@export var gradient:GradientTexture1D
@export var IngameSpeed = 1.0
@export var InitialHour = 12:
	set(h):
		InitialHour = h
		time = Ingame_to_real_minute_duration * InitialHour * MinuteperHour

#const NightColor = Color("#091d3a")
#const DayColor = Color("#52595f")
#const TimeScale = 0.1

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
	
func _recalculate_time() -> void:
	var total_minutes = int(time / Ingame_to_real_minute_duration)
	
	var day = int(total_minutes / MinutePerDay)
	
	var current_day_minutes = total_minutes % MinutePerDay
	
	var hour = int(current_day_minutes / MinuteperHour)
	var minute = int(current_day_minutes % MinuteperHour)
	
	
	
	
