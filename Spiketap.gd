extends Area2D


func _ready():
	$AnimationPlayer.play("SpikeTrigger")



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.player_state != body.state.ROLLING:
			body.player_health -= 10
		else:
			body.player_health -= 0
	
		print("player dead")
		


