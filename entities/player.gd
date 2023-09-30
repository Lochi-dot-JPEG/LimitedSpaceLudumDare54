extends CharacterBody2D

@export var drag = 0.98
@export var acceleration = 5
@export var rotational_drag = 0.8
var rotational_velocity = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down"))
	if input.length() > 0:
		input = input.normalized()
	#position += input
	rotational_velocity += input.x / 80
	rotate(rotational_velocity)
	velocity += Vector2(0,input.y * acceleration).rotated(rotation)
	velocity *= drag
	rotational_velocity*= rotational_drag
	
	move_and_slide()
