extends Control

var music = preload("res://main menu music for dvd sim '27.mp3")

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.stream = music
	audio_player.play()
