class_name PlayfieldBaseball
extends KinematicBody2D

export var BASEBALL_GRAVITY = 1.0 
var DELETE_Y = 250

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

var is_following_path = false
var current_velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_shape.disabled = true 

func _physics_process(_delta):
	if !is_following_path && current_velocity:
		#infinite inertia set to false, do we care about collsions with rigidbodies?
		move_and_collide(current_velocity , false, true, false)
		#Apply Gravity
		current_velocity.y += BASEBALL_GRAVITY * _delta 
		if global_position.y > DELETE_Y:
			queue_free();


func addVelocity( vel : Vector2 ):
	current_velocity = vel;
	
	
func addPath():
	pass

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
	

