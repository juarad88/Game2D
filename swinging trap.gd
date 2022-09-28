extends Node2D


func _ready():
	$AnimationPlayer.play("Swing")



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.player_state != body.state.ROLLING:
			body.player_health -= 25
		else:
			body.player_health -= 0
		print("player dead")
	
