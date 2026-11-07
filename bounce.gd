extends Sprite2D

@export var change_color_node: ColorRect
@export var speed: float = 200
var velocity: Vector2 = Vector2.ONE.normalized()

@onready var screen_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1,1))
	position = get_viewport_rect().size / 2

func _process(delta: float) -> void:
	position += velocity * speed * delta
	
	var rect = get_rect()
	var half_width = rect.size.x * scale.x / 2
	var half_height = rect.size.y * scale.y / 2
	
	var viewport_size = get_viewport_rect().size
	
	if position.x - half_width <= 0:
		position.x = half_width
		velocity.x = -velocity.x
		on_bounce()
	elif position.x + half_width >= viewport_size.x:
		position.x = viewport_size.x - half_width
		velocity.x = -velocity.x
		on_bounce()
	
	if position.y - half_height <= 0:
		position.y = half_height
		velocity.y = -velocity.y
		on_bounce()
	elif position.y + half_height >= viewport_size.y:
		position.y = viewport_size.y - half_height
		velocity.y = -velocity.y
		on_bounce()
	
func on_bounce() -> void:
	if change_color_node:
		change_color_node.color = Color(randf(), randf(), randf())
