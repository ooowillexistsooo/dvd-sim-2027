extends Control

@onready var container = $itemcontainer

@export var radius: Vector2 = Vector2(250, 100)
@export var spacing_angle: float = 45.0
@export var lerp_speed: float = 10.0
@export var max_scale: float = 1.2
@export var min_scale: float = 0.6

var current_angle_offset: float = 0.0
var target_angle_offset: float = 0.0
var selected_index: int = 0
var items: Array = []

func _ready():
	items = container.get_children()
	_update_positions(true)
	
func _unhandled_input(event):
	if event.is_action_pressed("mouse_button_wheel_up"):
		_change_selection(-1)
	elif event.is_action_pressed("mouse_button_wheel_down"):
		_change_selection(1)
		
func _process(delta) -> void:
	current_angle_offset = lerp(current_angle_offset, target_angle_offset, lerp_speed * delta)
	_update_positions(false)

func _change_selection(direction: int): 
	selected_index = clampi(selected_index + direction, 0, items.size() - 1)
	target_angle_offset = selected_index * deg_to_rad(spacing_angle)

func _update_positions(instant: bool):
	var spacing_rad = deg_to_rad(spacing_angle)
	
	for i in range(items.size()):
		var item_angle = (i * spacing_rad) - current_angle_offset
		var final_angle = item_angle + (PI / 2)
		var target_pos = Vector2(
			cos(final_angle) * radius.x,
			sin(final_angle) * radius.y
		)
		
		var proximity = cos(item_angle)
		
		var normal_prox = (proximity + 1) / 2
		var target_scale = lerp(min_scale, max_scale, normal_prox)
		
		if instant:
			items[i].position = target_pos
			items[i].scale = Vector2(target_scale, target_scale)
		else:
			items[i].position = lerp(items[i].scale, target_pos, 0.3)
			items[i].scale = lerp(items[i].scale, Vector2(target_scale, target_scale), 0.3)
		items[i].z_index = int(normal_prox * 100)
		
		items[i].modulate.a = lerp(0.4, 1.0, normal_prox)
