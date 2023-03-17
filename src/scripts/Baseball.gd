class_name Baseball
extends KinematicBody2D

export var TIME_UNTIL_DISAPPEARS = 10.0
export var BASEBALL_GRAVITY = 1.0 
export var SMALL_BALL_FRAMES = 40

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

var is_following_path = false
var current_velocity: Vector2
var current_frame = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Setting timeout")
	var timer := Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time= TIME_UNTIL_DISAPPEARS
	timer.start()
	timer.connect("timeout", self, "on_timeout")
	
	#Disable collisions for first X 'frames'
	collision_shape.disabled = true 
	sprite.scale = Vector2(0.5, 0.5)
	
	
	pass # Replace with function body.


func _physics_process(_delta):
	#tracks invuln and scaling
	current_frame +=1
	if (current_frame == 40):
		sprite.scale = Vector2(1, 1)
		collision_shape.disabled = false 
	
	if !is_following_path && current_velocity:
		print("physics step: ")
		print(current_frame)
		#infinite inertia set to false, do we care about collsions with rigidbodies?
		move_and_collide(current_velocity , false, true, false)
		
		#Apply Gravity
		current_velocity.y += BASEBALL_GRAVITY * _delta

	

func addVelocity( vel : Vector2 ):
	print("adding velocity to baseball . . . ")
	current_velocity = vel;
	
	
func addPath():
	pass

func on_timeout ():
	print("removing ball")
	queue_free();
