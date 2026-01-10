extends Node

const SAVE_PATH = "user://"


signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "res://playground.tscn",
	player = {
		hp = 99,
		max_hp = 10,
		fp = 99,
		max_fp = 10,
		pos_x = 240,
		pos_y = 240
	},
	items = [],
	persistence = [],
	quests = []
	
}

var DefaultData : Dictionary = current_save.duplicate(true)

# Called when the node enters the scene tree for the first time.
func save_game() -> void:
	update_player_data()
	update_item_data()
	update_scene_path()
	#save.sav : nama file
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	#mengubah penyimpanan
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	
	pass # Replace with function body.

func get_save_file() -> FileAccess:
	return FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_game() -> void:
	var file := get_save_file()
	var json := JSON.new()
	json.parse( file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	AreaManager.load_new_level( current_save.scene_path, "", Vector2.ZERO)
	await AreaManager.level_load_started

	PlayerManager.set_player_position(Vector2(
		current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	PlayerManager.set_hunger(current_save.player.fp, current_save.player.max_fp)
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.items)
	await AreaManager.level_loaded
	
	game_loaded.emit()
	pass


func update_player_data() -> void:
	var p : Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.fp = p.fp
	current_save.player.max_fp = p.max_fp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	

func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Area:
			p = c.scene_file_path
	current_save.scene_path = p


func update_item_data() -> void:
	current_save.items = PlayerManager.INVENTORY_DATA.get_save_data()
	
	

	
	
func reset_game() -> void:
	current_save = DefaultData.duplicate(true)
	
	PlayerManager.player._off_off()
	
	AreaManager.load_new_level( current_save.scene_path, "", Vector2.ZERO)
	await AreaManager.level_load_started

	PlayerManager.set_player_position(Vector2(
		current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	PlayerManager.set_hunger(current_save.player.fp, current_save.player.max_fp)
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.items)
	await AreaManager.level_loaded
	
	PlayerManager.player._on_on()
	
	game_loaded.emit()
	pass
	
