extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var TRAJECTORY_IS_PATH_CHANCE = 0.00

const Baseball = preload("res://scenes/Baseball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	if Input.is_action_just_pressed("debug_launch_baseball"):
		launch_baseball()

func launch_baseball():
	print("launching baseball bby")
	#instanciate a baseball at pos
	var baseball= Baseball.instance()
	baseball.global_position = global_position
	baseball.set_as_toplevel(true)
	add_child(baseball)
	
	
	var ball_type_roll = randf()
	
	#RNG trajectory type
	if ball_type_roll > TRAJECTORY_IS_PATH_CHANCE:
		baseball.addVelocity(generate_random_velocity());
	else:
		generate_path()

func generate_path():
	pass
	
func generate_random_velocity():
	print("physics based ball")
	var launch_vector = Vector2(1.0,-2.5)
	
	return launch_vector
