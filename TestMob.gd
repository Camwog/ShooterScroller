extends CharacterBody2D

enum States {ONFLOOR, JUMP, RUN, LAND, ATTACK}
var state
var last_state
var wall_counter = 0

const speed = 75.0
const JUMP_VELOCITY = -400.0
var heading = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func attack() :
	state = States.ATTACK
	velocity = Vector2(0,0)
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(1).timeout
	state = States.RUN 

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if state != States.ATTACK :
		velocity.x = speed * heading
	
	if is_on_wall() :
		heading *= -1
		
		scale.x = -1
	
		velocity.x = speed * heading
		
	if velocity.x != 0 and is_on_floor() :
		$AnimatedSprite2D.play("run")
		state = States.RUN
		
	if $RayCast2D.get_collider()  != null :
		if $RayCast2D.get_collider().name == "Player":
			attack()
			
		print($RayCast2D.get_collision_normal())
	
	
	
	move_and_slide()
	
	last_state = state
	pass
