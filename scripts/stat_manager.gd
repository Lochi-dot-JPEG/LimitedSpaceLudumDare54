extends Node
var enemy_spawn_rate = 2.0
var base_spawn_rate = 3.0
var player = null
var previous_score = 0
var high_score = 0
var default_layout = [
	null, #1
	null, #2
	null,
	null,#4
	null,
	null,#6
	null,
	null,#8
	null,
	"basic",#10
	null,
	null,#12
]
var player_parts = default_layout
var camera = null
var type_sprites = {
	"shotgun":preload("res://parts/gun1.png"),
	"basic":preload("res://parts/gun4.png"),
	"laser":preload("res://parts/gun3.png"),
}
var damage = {
	"shotgun":0.8,
	"basic":4,
	"laser":0.25,
	"e_melee":1,
	"e_orbit":1,
	"e_dart":1,
	
}
var speed = {
	"shotgun":800,
	"basic":500,
	"laser":3000,
	"e_orbit":300,
	"e_dart":300,
}
var lifetime = {
	"shotgun":0.2,
	"basic":10,
	"laser":0.5,
	"e_orbit":20,
	"e_dart":20,
	
}
var parts = {
	"basic":preload("res://parts/basic_gun.tscn"),
	"shotgun":preload("res://parts/shotgun.tscn"),
	"laser":preload("res://parts/laser_gun.tscn"),
}

var hp = {
	"e_melee":10,
	"e_orbit":8,
	"e_dart":8,
	"supply_crate":9999999,
}

var score = 0
var enemy_position_save = []
var player_position_save = []


var weight = 1
var player_health = 10
var crate_reward = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS



func _take_player_health(damage):
	_shake(30)
	_zoom(1.1)
	Stats._hitstop(10)
	Sound._play_sound("p_hit")
	player_health -= damage
	update_ui()
	if player_health < 1:
		_die()

func _update_weight():
	weight = 1
	for i in player_parts:
		if i != null:
			weight += 1


func _die():
	high_score = max(high_score,score)
	get_tree().call_deferred("change_scene_to_file","res://locations/Title/TitleScreen.tscn")




func update_ui():
	var ui = get_tree().get_first_node_in_group("ui")
	
	if ui != null:
		ui._update()

func _shake(amount):
	if camera != null and is_instance_valid(camera):
		camera._shake(amount)

func _zoom(amount):
	if camera != null and is_instance_valid(camera):
		camera._zoom(amount)

func _hitstop(frames):
	get_tree().paused = true
	for i in frames:
		await get_tree().process_frame
	get_tree().paused = false

func _add_score(amount):
	var old_score = int(score)
	score += amount
	if int(score) != old_score:
		update_ui()
