extends AudioStreamPlayer2D





func _ready():
	pass 

func _process_delta():
	
	if Input.is_action_just_pressed("jump"):
		$AudioStreamPlayer2D.play("Goat Scream - Sound Effect")
