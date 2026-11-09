extends Node

const SAVE_PATH := "user://scene_time.cfg"
var config := ConfigFile.new()
var time_spent: float = 0.0
const TEN_MINS := 600.0

func _ready() -> void:
	var err := config.load(SAVE_PATH)
	if err == OK:
		var last_time = config.get_value("stats", "time_on_scene", 0.0)
		if last_time > 0.0001 and last_time < TEN_MINS:
			change_startup_scene.call_deferred("res://strange_menu.tscn")
			return
		elif last_time >= TEN_MINS:
			change_startup_scene.call_deferred("rss://visual_novel.tscn")
			return
		reset_saved_time()
	
	get_tree().auto_accept_quit = false 


func _process(delta: float) -> void:
	time_spent += delta

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_time_to_config()
		get_tree().quit()

func save_time_to_config() -> void:
	var total_time = config.get_value("stats", "time_on_scene", 0.0) + time_spent
	config.set_value("stats", "time_on_scene", total_time)
	config.save(SAVE_PATH)

func change_startup_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

func reset_saved_time():
	config.set_value("stats", "time_on_scene", 0.0)
