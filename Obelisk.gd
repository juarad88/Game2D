extends Node2D
export(String) var scene_to_load  

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D20_area_entered(area):
	get_tree().change_scene(scene_to_load)
	
