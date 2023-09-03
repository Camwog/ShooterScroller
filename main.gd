extends Node2D

@export var current_level_scene: PackedScene
@export var player_scene: PackedScene
@export var test_mob_scene: PackedScene
var level
var test_mob


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	if current_level_scene != null:
		level = current_level_scene.instantiate()
	add_child(level)
#
#	
	
	
	
	
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
