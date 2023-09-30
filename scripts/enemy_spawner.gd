extends Node
var enemies = [
	preload("res://entities/enemies/melee_enemy.tscn"),
]
var upgrade_node = preload("res://entities/suppy_crate/supply_crate.tscn")
var difficulty_increase = 0.99
var enemy_timer : Timer

var enemy_ranges = []
func _ready() -> void:
	var view_size = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"),ProjectSettings.get_setting_with_override("display/window/size/viewport_height"))
	enemy_ranges.append([Vector2(0,0),Vector2(0,view_size.y)])
	enemy_ranges.append([Vector2(view_size.x,0),Vector2(view_size.x,view_size.y)])
	enemy_ranges.append([Vector2(0,0),Vector2(view_size.x,0)])
	enemy_ranges.append([Vector2(0,view_size.y),Vector2(view_size.x,view_size.y)])
	
	
	enemy_timer = Timer.new()
	add_child(enemy_timer)
	enemy_timer.wait_time = 0.1
	enemy_timer.connect("timeout",Callable(self,"_create_enemy"))
	enemy_timer.start()

func _create_enemy():
	
	enemy_timer.wait_time *= difficulty_increase
	enemy_timer.start()
	var _new_enemy = enemies.pick_random()
	if randf() < 1.08:
		_new_enemy = upgrade_node
	_new_enemy = _new_enemy.instantiate()
	get_parent().add_child(_new_enemy)
	var range = enemy_ranges.pick_random()
	_new_enemy.global_position = Vector2(randi_range(range[0].x,range[1].x),randi_range(range[0].y,range[1].y))
	#print("created_enemy")
