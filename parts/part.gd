extends Sprite2D
class_name Part
static var bullet_node = preload("res://entities/bullet/bullet.tscn")
@onready var bullet_parent = get_node("../../..")
@onready var shoot_from = get_node("ShootFrom")
var type = "basic"
func _use():
	pass

func _create_bullet(direction,speed,damage,lifetime,destroy_on_impact = true,show_bullet = true):
	var _new_bullet = bullet_node.instantiate()
	_new_bullet.collision_layer = 1
	_new_bullet.collision_mask = 8
	bullet_parent.add_child(_new_bullet)
	_new_bullet.global_position = shoot_from.global_position
	_new_bullet.direction = direction
	_new_bullet.speed = speed
	_new_bullet.damage = damage
	_new_bullet.lifetime = lifetime
	
	_new_bullet.destroy_on_impact = destroy_on_impact
	_new_bullet.visible = show_bullet
	return _new_bullet
