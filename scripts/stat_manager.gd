extends Node

var player_parts = [
	null, #1
	null, #2
	null,
	null,#4
	null,
	null,#6
	null,
	null,#8
	"basic",
	"basic",#10
	"basic",
	null,#12
]


var damage = {
	"shotgun":1,
	"basic":3,
	"laser":0.5,
	"e_melee":1,
}
var speed = {
	"shotgun":100,
	"basic":500,
	"laser":100,
}
var lifetime = {
	"shotgun":1,
	"basic":5,
	"laser":0.5,
}
var parts = {
	"basic":preload("res://parts/basic_gun.tscn")
}

var hp = {
	"e_melee":14,
	"supply_crate":9999999,
}

var player_health = 10
var crate_reward = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _take_player_health(damage):
	player_health -= damage
	update_ui()

func update_ui():
	var ui = get_tree().get_first_node_in_group("ui")
	
	if ui != null:
		ui._update()
