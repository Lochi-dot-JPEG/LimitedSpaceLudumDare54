extends CharacterBody2D
@onready var attach_point: Node2D = $AttachPoint

@export var drag = 0.98
@export var acceleration = 5
@export var rotational_drag = 0.8
var rotational_velocity = 0
@export var rotation_speed = 1.0
@export var part_width = 50

var shoot_timer : Timer

var parts = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_load_parts()
	
	shoot_timer = Timer.new()
	add_child(shoot_timer)
	shoot_timer.wait_time = 0.5
	shoot_timer.connect("timeout",Callable(self,"_shoot"))
	shoot_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down"))
	if input.length() > 0:
		input = input.normalized()
	#position += input
	rotational_velocity += input.x * rotation_speed / 1000
	rotate(rotational_velocity)
	velocity += Vector2(0,input.y * acceleration).rotated(rotation)
	velocity *= drag
	rotational_velocity*= rotational_drag
	
	move_and_slide()
	

func _load_parts():
	
	
	for i in attach_point.get_children():
		for child in i.get_children():
			child.queue_free()
	var ship_sides = Stats.player_parts
	var _add_to = 0
	print(ship_sides)
	
	
	var _point_in = 0
	for i in ship_sides:
		if i == null:
			_point_in += TAU/12
			continue
		var _current_part = 0
		var _new_part = Stats.parts[i].instantiate()
		attach_point.add_child(_new_part)
		
		_new_part.global_position = attach_point.global_position
		_new_part.global_rotation = _point_in
		_new_part.offset = Vector2(15,0)
		_current_part += 1
		_point_in += TAU/12
		parts.append(_new_part)


func _shoot():
	for i in parts:
		i._use()
