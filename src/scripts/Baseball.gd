class_name Baseball
extends KinematicBody2D

export var BASEBALL_GRAVITY = 1.0 
export var SMALL_BALL_TIME = 0.9
var DELETE_Y = 250

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D
onready var timer = $Timer

var is_following_path = false
var current_velocity: Vector2
var current_frame = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Setting timeout")
	timer.one_shot = true
	timer.wait_time= SMALL_BALL_TIME
	timer.start()
	timer.connect("timeout", self, "on_timeout")
	
	#Disable collisions for first X 'frames'
	collision_shape.disabled = true 
	sprite.scale = Vector2(0.5, 0.5)

func _physics_process(_delta):
	if !is_following_path && current_velocity:
		#print("physics step: ")
		#print(current_frame)
		#infinite inertia set to false, do we care about collsions with rigidbodies?
		move_and_collide(current_velocity , false, true, false)
		
		#Apply Gravity
		print(global_position)
		current_velocity.y += BASEBALL_GRAVITY * _delta 
		if global_position.y > DELETE_Y:
			queue_free();


func addVelocity( vel : Vector2 ):
	#print("adding velocity to baseball . . . ")
	current_velocity = vel;
	
	
func addPath():
	pass

func on_timeout ():
	sprite.scale = Vector2(1, 1)
	collision_shape.disabled = false 

func _on_Area2D_body_entered(body):
	BaseballEventsSingleton.emit_signal("catch_baseball")
	queue_free()


func _on_Area2D_area_entered(area):
	baseball_miss()

func baseball_miss():

	BaseballEventsSingleton.emit_signal("miss_baseball")

# called during the exit logic when this node is queued to be freed
func _on_Baseball_child_exiting_tree(node):
	BaseballEventsSingleton.emit_signal("destroy_baseball")
	

