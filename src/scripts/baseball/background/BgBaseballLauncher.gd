extends Node2D

export var BALL_VELOCITY :float = 1.0
export var BALL_ANGLE_DEGREES = 90

#Initial ball velocity should depend on the angle of the launch
#for example, a ball launched to the bottom left should move faster than one straight off the top of the screen
#we should work out what feels good for this at some point, possibly having some sort of function that provides an appropriate magnitude given an angle


const BgBaseball = preload("res://scenes/baseball/BgBaseball.tscn")

func _ready():
	BaseballEventsSingleton.connect("launch_baseball", self, "_on_bg_baseball_launch_event")


func _on_bg_baseball_launch_event():
	print("launch hit")
	launch_baseball()
	
func launch_baseball():
	#instanciate a baseball at pos
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var baseball= BgBaseball.instance()
	baseball.global_position = global_position
	#baseball.set_as_toplevel(true)
	get_parent().add_child(baseball)
	var launch_vector = Vector2(BALL_VELOCITY,0).rotated(rng.randf_range(0,359) * PI/180)
	baseball.addVelocity(launch_vector)
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("debug_launch_baseball"):
		#launch_baseball()
		pass
		
	

