extends Area2D
class_name Enemy

var move_tween : Tween
@onready var player = get_tree().get_first_node_in_group("player")
var type = "e_melee"
var hp = 1

var move_speed = 250
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_ready()
	collision_layer = 8
	collision_mask = 9
	hp = Stats.hp[type]
	connect("area_entered",Callable(self,"_area_entered"))

func _on_ready():
	pass


func _process(delta: float) -> void:
	pass


func _area_entered(area):
	if area.is_in_group("bullet"):
		_take_damage(area.damage)
		print("ouch")
		if area.destroy_on_impact:
			area.queue_free()


func _take_damage(damage):
	hp -= damage
	if hp <= 0:
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
