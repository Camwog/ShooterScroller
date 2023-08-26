extends CharacterBody2D


const speed = 75.0
const JUMP_VELOCITY = -400.0
var heading = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed * heading
	
	if is_on_wall() :
		heading *= -1
		
		scale.x =  heading
		
		velocity.x = speed * heading
		
		print("Heading : ", heading, "\n Scale.x: ", scale.x)
		
	
		
	
	print("Heading : ", heading, "\n Scale.x: ", scale.x, "\n Velocity: ", velocity.x)
	
	move_and_slide()
