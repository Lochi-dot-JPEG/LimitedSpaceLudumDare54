extends Area2D
class_name Enemy

var move_tween : Tween
@onready var player = get_tree().get_first_node_in_group("player")
var type = "e_melee"
var hp = 1
static var bullet_node = preload("res://entities/bullet/bullet.tscn")
@onready var bullet_parent = get_parent()
@onready var shoot_from = $ShootFrom
var move_speed = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_ready()
	collision_layer = 8
	collision_mask = 9
	hp = Stats.hp[type]
	print(type)
	print(hp)
	connect("area_entered",Callable(self,"_area_entered"))

func _on_ready():
	pass


func _process(delta: float) -> void:
	pass


func _area_entered(area):
	if area.is_in_group("bullet"):
		_take_damage(area.damage)
		if area.destroy_on_impact:
			area.queue_free()


func _take_damage(damage):
	hp -= damage
	if damage == 0.25:
		Sound._play_sound("laser")
		
	else:
		Stats._shake(5)
		Sound._play_sound("hit",-15 + damage * 4)
	if hp <= 0:
		Sound._play_sound("explosion",-10)
		queue_free()

func _body_entered(_body):
	pass



func _queue_move_to_point(target : Vector2) -> void:
	if not move_tween or not move_tween.is_running():
		move_tween = create_tween().set_trans(Tween.TRANS_SINE)
	
	var time = target.distance_to(global_position) / move_speed
#
	rotation = global_position.angle_to_point(target)
	move_tween.tween_property(self,"global_position",target,time)

func _create_bullet(direction,speed,damage,lifetime,destroy_on_impact = true,show_bullet = true):
	var _new_bullet = bullet_node.instantiate()
	bullet_parent.add_child(_new_bullet)
	_new_bullet.global_position = shoot_from.global_position
	_new_bullet.direction = direction
	_new_bullet.speed = speed
	_new_bullet.damage = damage
	_new_bullet.lifetime = lifetime
	_new_bullet.destroy_on_impact = destroy_on_impact
	_new_bullet.visible = show_bullet
