extends Node
#var enemies = [
	#preload("res://entities/enemies/melee_enemy.tscn"),
	#preload("res://entities/enemies/orbit_enemy.tscn"),
	#preload("res://entities/enemies/dart_enemy.tscn"),
#]
var enemies = {
	"e_melee":preload("res://entities/enemies/melee_enemy.tscn"),
	"e_orbit":preload("res://entities/enemies/orbit_enemy.tscn"),
	"e_dart":preload("res://entities/enemies/dart_enemy.tscn"),
	"supply_crate":preload("res://entities/suppy_crate/supply_crate.tscn")
}
var enemy_choices = [
	"e_melee","e_orbit","e_dart"
]
#var upgrade_node = 
var difficulty_increase = 0.97
var enemy_timer : Timer


var enemies_since_last = 0
var enemy_ranges = []
func _ready() -> void:
	var view_size = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"),ProjectSettings.get_setting_with_override("display/window/size/viewport_height"))
	enemy_ranges.append([Vector2(0,0),Vector2(0,view_size.y)])
	enemy_ranges.append([Vector2(view_size.x,0),Vector2(view_size.x,view_size.y)])
	enemy_ranges.append([Vector2(0,0),Vector2(view_size.x,0)])
	enemy_ranges.append([Vector2(0,view_size.y),Vector2(view_size.x,view_size.y)])
	
	for i in 4:
		enemy_ranges[i-1][0] -= view_size/2
		enemy_ranges[i-1][1] -= view_size/2
	
	enemy_timer = Timer.new()
	add_child(enemy_timer)
	enemy_timer.wait_time = Stats.enemy_spawn_rate
	enemy_timer.connect("timeout",Callable(self,"_create_enemy"))
	enemy_timer.start()
	_load_enemies()

func _create_enemy():
	enemy_timer.wait_time *= difficulty_increase
	enemy_timer.wait_time = clamp(enemy_timer.wait_time,0.5,100)
	Stats.enemy_spawn_rate = enemy_timer.wait_time
	print("spawn_rate = " + str(enemy_timer.wait_time))
	enemy_timer.start()
	var _new_enemy = enemy_choices.pick_random()
	if enemies_since_last > 5 and randf() < 0.3:
		_new_enemy = "supply_crate"
		enemies_since_last = 1
		print("new_supply crate")
	enemies_since_last += 1
	_new_enemy = enemies[_new_enemy].instantiate()
	get_parent().add_child(_new_enemy)
	var _range = enemy_ranges.pick_random()
	_new_enemy.global_position = Vector2(randi_range(_range[0].x,_range[1].x),randi_range(_range[0].y,_range[1].y))

func _save_enemies():
	var _en = []
	for i in get_parent().get_children():
		if i == self or not i.is_in_group("save_this"):
			continue
		_en.append([i.type,i.hp,i.position])
	Stats.enemy_position_save = _en

func _load_enemies():
	await get_parent().ready
	var _loaded_enemies = Stats.enemy_position_save
	for i in _loaded_enemies:
		var _new_enemy = enemies[i[0]].instantiate()
		get_parent().add_child(_new_enemy)
		_new_enemy.hp = i[1]
		_new_enemy.position = i[2]
