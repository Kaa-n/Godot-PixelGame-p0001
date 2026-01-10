extends Node

@onready var playground: Area = $".."

var enemy1 = preload("res://Enemies/Slime/Slime.tscn")
var enemy2 = preload("res://Enemies/Beetle/Beetle.tscn")

@onready var pixelart_loteng_1: TileMapLayer = $"../Pixelart-loteng1"



#@onready var spawned_enemies: Node2D = $SpawnedEnemies
#
#@export var max_enemies = 20 
#var enemy_count = 0 
#var rng = RandomNumberGenerator.new()


enum TerrainType {
	WALL = 3,
	SPAWN = 0
}

const WALL = 3
const SPAWN = 0

func _ready() -> void:
	#is_valid_spawn_location()
	pass 



func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	randomize()
	var enemies = [enemy1, enemy2] 
	
	var kinds = enemies[randi() % enemies.size()] #hasil mod 2 antara 0 sampai 1
	
	print("p", PlayerManager.player.position)
	
	var y_down = PlayerManager.player.position.y + 200
	var y_up = PlayerManager.player.position.y - 200
	var spawn_down = Vector2( randi_range(115,360), randi_range(y_down,550) )
	var spawn_up = Vector2( randi_range(115,360), randi_range(y_up,200) )
	
	var spawns = [spawn_down, spawn_up]
	var spawn_area = spawns [randi() % spawns.size()]
	print("Spawn Area: ", spawn_area)
	
	#mencari tahu korrdinat spawn_area di tilemap pixelart_loteng 1
	
	
	
	
	var tile_spawn : Vector2i = pixelart_loteng_1.local_to_map(spawn_area)
	print("b: ", tile_spawn)
	
	var tile_data: TileData = pixelart_loteng_1.get_cell_tile_data(tile_spawn)
	
	print("Tile Data: ", tile_data)
	if tile_data != null:
		var check = tile_data.get_custom_data("Terrain")
		print("chc: ", check)
		if check == 0:
			var enemy = kinds.instantiate()
			print("e: ", enemy)
			enemy.position = spawn_area
			print("e: ", enemy.position)
			playground.add_child(enemy)
			$Timer.wait_time = randi_range(10,15)
	else:
		$Timer.wait_time = 0.0001
		
		pass
		
	
		
		
		
	#for i in valid_cells.size():
		#if spawn_area == valid_cells[i]:
			#enemy.position = spawn_area
			#add_child(enemy)
			#
	
	
	
#func is_valid_spawn_location(layer, position):
	#var cell_coords = Vector2(position.x, position.y)
	#
	#if pixelart_loteng_1.get_cell_source_id(SPAWN, cell_coords) != -1 || pixelart_loteng_1.get_cell_source_id(WALL, cell_coords) != -1:
		#return true
	#return false
