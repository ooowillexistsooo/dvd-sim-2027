extends Control

@onready var hour_box: SpinBox = $CenterContainer/VBoxContainer/HBoxContainer/hour
@onready var minute_box: SpinBox = $CenterContainer/VBoxContainer/HBoxContainer/minute
@onready var title_label: Label = $CenterContainer/VBoxContainer/HBoxContainer/Label
@onready var confirm_button: Button = $CenterContainer/VBoxContainer/Button

var progression_step: int = 0

func _ready() -> void:
	confirm_button.pressed.connect(_on_confirm_pressed)
	
func _on_confirm_pressed() -> void:	
	var current_time = Time.get_time_dict_from_system()
	var real_hour = current_time["hour"]
	var real_minute = current_time["minute"]
	
	match progression_step:
		0:
			var input_hour = int(hour_box.value)
			var input_minute = int(minute_box.value)
			if input_hour == real_hour and abs(input_minute - real_minute) <= 2:
				confirm_button.disabled = true
				title_label.text = "you win the game! mike, cue the music."
				# mike, please actually add music later.
				await get_tree().create_timer(2.5).timeout
				title_label.text = "did you really think it was that easy? ha."
				await get_tree().create_timer(2.5).timeout
				progression_step = 1
				setup_next_setting()
			else:
				confirm_button.disabled = true
				title_label.text = "you know what they say about liars."
				await get_tree().create_timer(2).timeout
				title_label.text = "they die a painful death."
				await get_tree().create_timer(2).timeout
				title_label.text = "dont let that happen to you."
				await get_tree().create_timer(2).timeout
				title_label.text = "now, i'm going to let you try again."
				await get_tree().create_timer(2).timeout
				title_label.text = "don't lie this time."
				await get_tree().create_timer(2).timeout
				title_label.text = ":"
				confirm_button.disabled = false
		1:
			$CenterContainer/VBoxContainer/Label.text = "Thank you for your Input."
			await get_tree().create_timer(2).timeout
			get_tree().change_scene_to_file("res://menu.tscn")

func setup_next_setting() -> void:
	confirm_button.disabled = false
	hour_box.get_parent().queue_free()
	$CenterContainer/VBoxContainer/Label.text = "Please describe this frog."
	
	var slider := HSlider.new()
	var frogimg := TextureRect.new()
	frogimg.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	frogimg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	frogimg.custom_minimum_size = Vector2(1, 1)
	frogimg.custom_maximum_size = Vector2(250,200)
	slider.min_value = 0
	slider.max_value = 100
	slider.value = 50
	frogimg.texture = load("res://betterfrog.jpg")
	frogimg.scale = Vector2(0.1, 0.1)
	$CenterContainer/VBoxContainer.add_child(frogimg)
	$CenterContainer/VBoxContainer.add_child(slider)
	$CenterContainer/VBoxContainer.move_child(confirm_button, -1)
