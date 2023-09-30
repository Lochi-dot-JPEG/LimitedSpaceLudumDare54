extends Sprite2D
class_name Part
static var bullet_node = preload("res://entities/bullet/bullet.tscn")
@onready var bullet_parent = get_node("../../..")
@onready var shoot_from = get_node("ShootFrom")
var type = "basic"
func _use():
	pass

func _create_bullet(direction,speed,damage,lifetime):
	var _new_bullet = bullet_node.instantiate()
	bullet_parent.add_child(_new_bullet)
	_new_bullet.global_position = shoot_from.global_position
	_new_bullet.direction = direction
	_new_bullet.speed = speed
	_new_bullet.damage = damage
	_new_bullet.lifetime = lifetime
	_new_bullet.collision_layer = 1
	_new_bullet.collision_mask = 8
