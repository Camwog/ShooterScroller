extends CharacterBody2D

signal attack_sig

var enemy = true

enum States {ONFLOOR, JUMP, RUN, LAND, ATTACK}
var state
var last_state
var wall_counter = 0


var health = 5

const speed = 75.0
const JUMP_VELOCITY = -400.0
var heading = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func on_hit(dmg):
	health = health - dmg
	$TextureProgressBar.value = health
	print("Mob health: ", health)

func attack() :
	state = States.ATTACK
	velocity = Vector2(0,0)
	$AnimatedSprite2D.play("attack")
	var current_frame = $AnimatedSprite2D.get_frame()
	if (current_frame > 4 and current_frame < 6 and $RayCast2D.get_collider().name == "Player") :
		$RayCast2D.get_collider().on_hit(1)
	await get_tree().create_timer(0.5).timeout
	state = States.RUN 
	
func flip_character_h():
	heading *= -1

	scale.x = -1

	velocity.x = speed * heading

func _ready():
	
	
		
	add_to_group("Characters")
	$TextureProgressBar.max_value = health
	$TextureProgressBar.value = health
	

func _physics_process(delta):
	
	if health <= 0 :
		queue_free()
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if state != States.ATTACK :
		velocity.x = speed * heading
	
		
	if velocity.x != 0 and is_on_floor() :
		$AnimatedSprite2D.play("run")
		state = States.RUN
		
	if $RayCast2D.get_collider()  != null :
		if $RayCast2D.get_collider().name == "Player":
			await attack()
		else : flip_character_h()
		
	if $RayCast2D2.get_collider() == null : 
		flip_character_h()
	
	move_and_slide()
	
	last_state = state
	pass

func init_heading(new_heading) :
	heading = new_heading
	if new_heading == -1 :
		scale.x = -1

func set_heading(new_heading) :
	heading = new_heading

func get_heading() :
	return heading
