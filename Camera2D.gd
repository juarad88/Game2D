extends Camera2D

var zoomed = true
var center = Vector2.ZERO
onready var target = get_parent().get_node("Player")

func _ready():
	center = get_viewport_rect().size/2


func _process(delta):
#	if Input.is_action_just_pressed("zoom"):
#		if zoomed:
#			target = null
#			zoomed = false
#		else:
#			target = owner.get_node("Player")
#			zoomed = true 
			
	if zoomed:
		position = target.global_position
		zoom = Vector2(0.3,0.3)
		#position = position.move_toward(target.global_position, 80)
		
	else:
		zoom = zoom.move_toward(Vector2(1,1), 0.03)
		position = position.move_toward(center, 80)
