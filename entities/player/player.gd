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

func _ready() -> void:
	Stats.player = self
	position = Stats.player_position_save
	_load_parts()
	
	shoot_timer = Timer.new()
	add_child(shoot_timer)
	shoot_timer.wait_time = 0.5
	shoot_timer.connect("timeout",Callable(self,"_shoot"))
	shoot_timer.start()


func _process(delta: float) -> void:
	Stats._add_score(delta * 10)
	var input = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down"))
	#if input.length() > 0:
		#input = input.normalized()
	#rotational_velocity += input.x * rotation_speed / 1000
	#rotate(rotational_velocity)
	#velocity += Vector2(0,input.y * acceleration).rotated(rotation)
	#velocity *= drag
	#rotational_velocity*= rotational_drag
	if input.length() > 0:
		input = input.normalized()
	velocity += input * acceleration * delta * (1.0 - Stats.weight/14.0)
	velocity *= drag# - (Stats.weight/20)
	$Ship.rotation = velocity.angle()
	move_and_slide()
	

func _load_parts():
	
	
	for i in attach_point.get_children():
		for child in i.get_children():
			child.queue_free()
	var ship_sides = Stats.player_parts
	var _add_to = 0
	
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
	var part_sound_count = 0
	
	for i in parts:
		i._use()
		if i.type != "laser":
			part_sound_count += 1
	if part_sound_count > 0:
		Sound._play_sound("shoot",-25 + part_sound_count * 2)


func _on_damage_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		Stats._take_player_health(area.damage)
		area.queue_free()
