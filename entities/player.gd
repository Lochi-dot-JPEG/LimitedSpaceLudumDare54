extends CharacterBody2D
@onready var attach_points: Node2D = $AttachPoints

@export var drag = 0.98
@export var acceleration = 5
@export var rotational_drag = 0.8
var rotational_velocity = 0
@export var part_width = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_parts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down"))
	if input.length() > 0:
		input = input.normalized()
	#position += input
	rotational_velocity += input.x / 100
	rotate(rotational_velocity)
	velocity += Vector2(0,input.y * acceleration).rotated(rotation)
	velocity *= drag
	rotational_velocity*= rotational_drag
	
	move_and_slide()

func _load_parts():
	
	
	for i in attach_points.get_children():
		for child in i.get_children():
			child.queue_free()
	var ship_sides = Stats.player_parts
	var _add_to = 0
	print(ship_sides)
	
	for i in ship_sides:
		print(i)
		var _part_parent = attach_points.get_child(_add_to)
		var total_width = part_width *( i.size() - 1)
		var point_direction = _part_parent.target_position.angle()
		var align_along = abs(_part_parent.target_position.rotated(deg_to_rad(90)).normalized())
		var _current_part = 0
		for part in i:
			
			var _new_part = Stats.parts[part].instantiate()
			_part_parent.add_child(_new_part)
			var pos = _part_parent.global_position
			var _offset = total_width / i.size() * _current_part - total_width / 3
			pos += align_along * Vector2(_offset,_offset)
			print(align_along)
			_new_part.global_position = pos
			_new_part.global_rotation = _part_parent.global_rotation + point_direction
			_current_part += 1
		_add_to += 1

func _save_parts():
	pass
