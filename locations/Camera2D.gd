extends Camera2D

@onready var player = $"../Player"

var shake = Vector2.ZERO
const decay = 0.7

func _ready() -> void:
	Stats.camera = self


func _process(delta: float) -> void:
	position = player.global_position * zoom / 8  + shake
	zoom = zoom.move_toward(Vector2(1,1),delta * 5)
	shake *= -decay

func _shake(amount):
	if amount > abs(shake.x):
		var rand_shake = randf()
		if rand_shake < 0.25:
			shake = Vector2(amount,-amount)
		elif rand_shake < 0.5:
			shake = Vector2(-amount,-amount)
		elif rand_shake < 0.75:
			shake = Vector2(-amount,amount)
		else:
			shake = Vector2(amount,amount)

func _zoom(amount:float):
	zoom = Vector2(amount,amount)
