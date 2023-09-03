extends CharacterBody2D

enum States {STATE_ONFLOOR, STATE_JUMP, STATE_RUN, STATE_LAND, STATE_ATTACK}
var last_state
var state
var health = 10

var sword_dmg = 3

@export var SPEED = 150
@export var JUMP_VELOCITY = -500.00

func on_hit(dmg):
	health = health - dmg
	print("Health :", health)
	
func sword_attack() :
	$AnimatedSprite2D.play("sword_atk")
	while($AnimatedSprite2D.animation == "sword_atk") :
		if $RayCast2D.is_colliding() and $AnimatedSprite2D.get_frame() == 3 :
			var collider = $RayCast2D.get_collider()
			if "enemy" in collider :
				collider.on_hit(sword_dmg)
		await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(0.5).timeout

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
		$RayCast2D.rotation_degrees = 0
		if is_on_floor() :
			$AnimatedSprite2D.play("run")
			state = States.STATE_RUN
	elif velocity.x < 0 :
		$AnimatedSprite2D.set_flip_h(true)
		$RayCast2D.rotation_degrees = 180
		if is_on_floor() :
			$AnimatedSprite2D.play("run")
			state = States.STATE_RUN
		
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
		state = States.STATE_JUMP
		
	if Input.is_action_just_pressed("attack") and state != States.STATE_JUMP :
		await sword_attack()
		
	if last_state == States.STATE_JUMP and is_on_floor() :
		$AnimatedSprite2D.play("land")
	
	
	last_state = state
	
	#print(state)

	move_and_slide()
	
	
