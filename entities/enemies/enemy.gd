extends Area2D
class_name Enemy

var type = "e_melee"
var hp = 1
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
	
