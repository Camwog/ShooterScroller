extends CharacterBody2D

enum States {STATE_ONFLOOR, STATE_JUMP, STATE_RUN, STATE_LAND}
var last_state
var state

@export var SPEED = 150
@export var JUMP_VELOCITY = -500.00

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta 
	else : state = States.STATE_ONFLOOR
		
	if is_on_floor() and !$AnimatedSprite2D.is_playing() :
		$AnimatedSprite2D.play("idle")
		

	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 0 :
		$AnimatedSprite2D.set_flip_h(false)
		if is_on_floor() :
			$AnimatedSprite2D.play("run")
			state = States.STATE_RUN
	elif velocity.x < 0 :
		$AnimatedSprite2D.set_flip_h(true)
		if is_on_floor() :
			$AnimatedSprite2D.play("run")
			state = States.STATE_RUN
		
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
		state = States.STATE_JUMP
		
	if last_state == States.STATE_JUMP and is_on_floor() :
		$AnimatedSprite2D.play("land")
	
	
	last_state = state
	
	print(state)

	move_and_slide()
	
	
