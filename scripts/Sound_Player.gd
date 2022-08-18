extends Node


func _ready():
	if $AudioStreamPlayer2D.playing == false:
		$AudioStreamPlayer2D.play()
	pass

