extends Node2D

export var TRAJECTORY_IS_PATH_CHANCE = 0.00
export var BALL_VELOCITY :float = 2.5
export var BALL_ANGLE_DEGREES = 45
export var BALL_ANGLE_RADS = 0

const Baseball = preload("res://scenes/Baseball.tscn")

func _ready():
#	BaseballEventsSingleton.connect("launch_baseball", self, "_on_BaseballEventsSingleton_launch_baseball")
	BaseballEventsSingleton.connect("destroy_background_baseball", self , "launch_from_bg")

func launch_from_bg(destroyed_position: Vector2, destroyed_velocity: Vector2):
	print("launch from bg hit")
	var flipped_velocity = Vector2(destroyed_velocity.x, destroyed_velocity.y * -1.0)
	var launch_angle = flipped_velocity.angle()
	var start_x = (destroyed_position.x - ( Globals.SCREEN_WIDTH / 2.0 )) * -1.0 # reflects X position over midpoint of screen
	start_x = start_x + ( Globals.SCREEN_WIDTH / 2.0 )
	var start_y = (destroyed_position.y - ( Globals.SCREEN_HEIGHT / 2.0 )) * -1.0 # reflects Y
	start_y = start_y + ( Globals.SCREEN_HEIGHT / 2.0 )
	#set params for launch
	global_position = Vector2( start_x, start_y)
	BALL_ANGLE_RADS = launch_angle
	
	launch_baseball()
	
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
	#var launch_vector = Vector2(BALL_VELOCITY,0).rotated( - BALL_ANGLE_DEGREES * PI/180)
	var launch_vector = Vector2(BALL_VELOCITY,0).rotated( - BALL_ANGLE_RADS)
	
	return launch_vector

func _on_BaseballEventsSingleton_launch_baseball():
	launch_baseball()
