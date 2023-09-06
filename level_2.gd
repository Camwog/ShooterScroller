extends Node

var rng = RandomNumberGenerator.new()

@export var test_mob_scene: PackedScene
var mob

func spawn(packed_scene, position, count ) :
	for i in count :
		var time_variance = rng.randf_range(0.1, 5.0)
		mob = packed_scene.instantiate()
		add_child(mob)
		
		mob.position = position
		mob.position.x += time_variance
		
		if randi() % 2 == 0 :
			mob.get_node("CharacterBody2D").flip_character_h()
		print(mob.get_node("CharacterBody2D").get_heading())
		await get_tree().create_timer(time_variance).timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	spawn(test_mob_scene, $SpawnPoints/Marker1.position, 1)
	#spawn(test_mob_scene, $SpawnPoints/Marker2.position, 0)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
