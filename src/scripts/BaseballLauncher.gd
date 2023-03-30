extends Node2D

export var TRAJECTORY_IS_PATH_CHANCE = 0.00
export var BALL_VELOCITY :float = 2.5
export var BALL_ANGLE_DEGREES = 45

const Baseball = preload("res://scenes/Baseball.tscn")

func _ready():
	BaseballEventsSingleton.connect("launch_baseball", self, "_on_BaseballEventsSingleton_launch_baseball")

func launch_baseball():
	#print("launching baseball bby")
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
	#print("physics based ball")
	#var launch_vector = Vector2(1.0,-2.5)
	var launch_vector = Vector2(BALL_VELOCITY,0).rotated( - BALL_ANGLE_DEGREES * PI/180)
	
	return launch_vector

func _on_BaseballEventsSingleton_launch_baseball():
	launch_baseball()
