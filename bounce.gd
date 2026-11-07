extends Sprite2D

@export var change_color_node: ColorRect
@export var count_label: Label
@export var speed: float = 200
var velocity: Vector2 = Vector2.ONE.normalized()

var corner_bounce_count: int = 0

@onready var screen_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1,1))
	position = get_viewport_rect().size / 2
	update_label_text()

func _process(delta: float) -> void:
	position += velocity * speed * delta
	
	var rect = get_rect()
	var half_width = rect.size.x * scale.x / 2
	var half_height = rect.size.y * scale.y / 2
	
	var viewport_size = get_viewport_rect().size
	
	var bounced_x: bool = false
	var bounced_y: bool = false
	
	if position.x - half_width <= 0:
		position.x = half_width
		velocity.x = -velocity.x
		bounced_x = true
	elif position.x + half_width >= viewport_size.x:
		position.x = viewport_size.x - half_width
		velocity.x = -velocity.x
		bounced_x = true
	
	if position.y - half_height <= 0:
		position.y = half_height
		velocity.y = -velocity.y
		bounced_y = true
	elif position.y + half_height >= viewport_size.y:
		position.y = viewport_size.y - half_height
		velocity.y = -velocity.y
		bounced_y = true
		
	if bounced_x or bounced_y:
		on_bounce(bounced_x and bounced_y)
	
func on_bounce(is_corner: bool) -> void:
	if is_corner:
		corner_bounce_count += 1
		update_label_text()
		
	if change_color_node:
		change_color_node.color = Color(randf(), randf(), randf())

func update_label_text() -> void:
	if count_label:
		count_label.text = "Corner Hits: " + str(corner_bounce_count)
