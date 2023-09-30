extends Node
var enemy_spawn_rate = 3.0
var base_spawn_rate = 3.0
var default_layout = [
	null, #1
	"shotgun", #2
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
	"basic":3,
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
	"shotgun":0.3,
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
	"e_melee":14,
	"e_orbit":9,
	"e_dart":9,
	"supply_crate":9999999,
}


var weight = 1
var player_health = 10
var crate_reward = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _take_player_health(damage):
	_shake(30)
	_zoom(1.5)
	Sound._play_sound("p_hit")
	player_health -= damage
	update_ui()

func _update_weight():
	weight = 1
	for i in player_parts:
		if i != null:
			weight += 1

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
