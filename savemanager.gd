extends Node

const SAVE_PATH = "user://useless-config.cfg"
var config = ConfigFile.new()

var launch_count = 0
var favorite_time = ""
var frog_love := 50

func _ready() -> void:
	load_settings()
	launch_count += 1
	save_settings()
	
func save_settings():
	config.set_value("Meta", "launch-count", launch_count)
	config.set_value("Meta", "favorite-time", favorite_time)
	config.set_value("Meta", "frog-love", frog_love)
	config.save(SAVE_PATH)

func load_settings():
	if config.load(SAVE_PATH) == OK:
		launch_count = config.get_value("Meta", "launch-count", 0)
		favorite_time = config.get_value("Meta", "favorite-time", "")
		frog_love = config.get_value("Meta", "frog-love", 50)
