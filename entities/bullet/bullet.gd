extends Area2D

var direction : Vector2
var speed : float
var damage
var destroy_on_impact = true

var lifetime = 1

func _physics_process(delta: float) -> void:
	position += direction * delta * speed
	lifetime -= delta
	if lifetime < 0:
		queue_free()
