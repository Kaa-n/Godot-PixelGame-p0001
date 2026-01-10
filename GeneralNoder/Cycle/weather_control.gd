extends StaticBody2D


var current_weather = "none" #none, rain

# Called when the node enters the scene tree for the first time.
func _ready():
	if current_weather == "none":
		$GPUParticles2D.visible = false
	if current_weather == "rain":
		$GPUParticles2D.visible = true
	
	


func _on_timer_timeout():
	if current_weather == "none":
		current_weather = "rain"
		$Timer.wait_time = randf_range(40.0, 60.0)
		$Timer.start()
	elif current_weather == "rain":
		current_weather = "none"
		$Timer.wait_time = randf_range(15.0, 40.0)
		$Timer.start()
		

func _process(delta):
	
	AreaManager.weather = current_weather
	if current_weather == "none":
		$GPUParticles2D.visible = false
	if current_weather == "rain":
		$GPUParticles2D.visible = true
