extends Node2D
export (int) var follow_speed = 50
func _ready():
	$AnimationPlayer.play("Spin")

func _process(delta):
	$Path2D/PathFollow2D.offset += follow_speed * delta
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.player_state != body.state.ROLLING:
			body.player_health -= 50
		else:
			body.player_health -= 0
		print("player dead")

