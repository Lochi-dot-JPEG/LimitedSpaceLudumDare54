extends Control

@onready var pivot_from: Control = $PivotFrom

var held = false

var _snap_from = 80
@onready var snap_point_parent: Control = $"../Ship/Snap_Points"

var snap_points = []
var type = "basic"
var attached_to = null


var other_parts = []
func _ready() -> void:
	for i in snap_point_parent.get_children():
		snap_points.append([i,i.global_position])
	_scan_for_others()
	$TextureRect.texture = Stats.type_sprites[type]


func _scan_for_others():
	other_parts = []
	for i in get_parent().get_children():
		if i.is_in_group("part") and i != self and not i.is_queued_for_deletion():
			other_parts.append(i)


func _process(_delta: float) -> void:
	if held:
		position = get_global_mouse_position() - pivot_from.position

func _input(event: InputEvent) -> void:
	if held and event is InputEventMouseMotion:
		position += event.relative

#func _on_pressed() -> void:
	#held = true


func _on_button_down() -> void:
	pivot_from.global_position = get_global_mouse_position()
	rotation = 0
	held = true


func _on_button_up() -> void:
	held = false
	
	var closest = 999999999
	var closest_node = null
	for i in snap_points:
		var _distance = get_global_mouse_position().distance_to(i[1])
		if _distance < closest:
			var taken = false
			for o in other_parts:
				if o.attached_to == i[0]:
					taken = true
			if not taken:
				closest = _distance
				closest_node = i[0]
				attached_to = closest_node
	if closest_node == null or closest > _snap_from:
		attached_to = null
		return
	Sound._play_sound("attach_part")
	global_position = closest_node.global_position - Vector2(0,24)
	rotation = closest_node.global_position.angle_to_point(Vector2(461,266)) + PI
	
func _attach_to_part(index):
	global_position = snap_points[index][1] - Vector2(0,24)
	print(global_position)
	attached_to = snap_points[index][0]
	rotation = (global_position + Vector2(0,24)).angle_to_point(Vector2(461,266)) + PI
