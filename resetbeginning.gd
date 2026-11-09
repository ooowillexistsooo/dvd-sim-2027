extends Button

@export var config_path := "user://useless-config.cfg"

func _on_begin_pressed() -> void:
	var config = ConfigFile.new()
	
	config.clear()
	config.save(config_path)
