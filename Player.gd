extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -180
export (int) var gravity = 400
export (int) var slide_speed = 400

var can_jump = true
var velocity = Vector2.ZERO
var player_health = 100

export (float) var friction = 10 
export (float) var acceleration = 25

enum state {IDLE, RUNNING, PUSHING, ROLLING, JUMP, STARTJUMP, FALL, ATTACK, WALLJUMP}

onready var player_state = state.IDLE
onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
	state_machine.travel("idle")
	pass


func update_animation(anim):
	if velocity.x < 0:
		$Sprite.flip_h = true
	elif velocity.x > 0:
		$Sprite.flip_h = false
	match(anim):
		state.FALL:
			state_machine.travel("fall")
		state.ATTACK:
			state_machine.travel("attack")
		state.IDLE:
			state_machine.travel("idle")
		state.JUMP:
			state_machine.travel("jump")
		state.PUSHING:
			state_machine.travel("pushing")
		state.RUNNING:
			state_machine.travel("running")
		state.ROLLING:
			state_machine.travel("roll")
			
			

func handle_state(player_state):
	match(player_state):
		state.STARTJUMP:
			velocity.y = jump_speed
		state.WALLJUMP:
			velocity.y = jump_speed*.75
			if $Sprite.flip_h == false:
				velocity.x = -250
			else:
				velocity.x = 250
	pass
	
func get_input():
	var dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, acceleration)
	else: 
		velocity.x = move_toward(velocity.x, 0, friction) 

func _physics_process(delta):
	get_input()
	if velocity == Vector2.ZERO:
		player_state = state.IDLE
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_state = state.STARTJUMP
		can_jump = true
		
		
	elif velocity.x != 0:
		player_state = state.RUNNING
	
	if Input.is_action_just_pressed("Roll"):
		player_state = state.ROLLING
		
	if not is_on_floor():
		if velocity.y < 0:
			player_state = state.JUMP
		if velocity.y >0:
			player_state = state.FALL
		if Input.is_action_just_pressed("Roll"):
			player_state = state.ROLLING	
		if Input.is_action_just_pressed("jump") and is_on_wall() and $RayCast2D.is_colliding() == false:
			player_state = state.WALLJUMP
		if Input.is_action_just_pressed("jump") and can_jump == true:
			player_state = state.STARTJUMP
			can_jump = false
	if player_health <= 0:
		GameStats.reset()
		
	$CanvasLayer/Control/ProgressBar.value = player_health	

	
#		elif player_state == state.JUMP and velocity.y >0:
#
#
#		
#			if Input.is_action_just_pressed("Roll"):
#				player_state = state.ROLLING
	handle_state(player_state)
	update_animation(player_state)
	
	#set gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


#func _on_Deathzone_area_entered(area):
#	if area.is_in_group("Deadly"):
#		if GameStats.check_reset() == false:
#			global_position = GameStats.get_spawn().global_position
