class_name BgBaseball
extends KinematicBody2D

export var BASEBALL_GRAVITY = 0.0 

export var MIN_BASEBALL_SCALE = 0.1
export var MAX_BASEBALL_SCALE = 0.6

export var BASEBALL_SCALE_STEP = 0.15
export var BASEBALL_VELOCITY_SCALER_STEP = 1.2;
 
#export var MAX_DISTANCE = 300 
export var BOTTOM_DESTROY_BOUNDS = Globals.SCREEN_HEIGHT + 10
export var TOP_DESTROY_BOUNDS = -10
export var RIGHT_DESTROY_BOUNDS = Globals.SCREEN_WIDTH + 10
export var LEFT_DESTROY_BOUNDS = -10


onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D
onready var timer = $Timer
var current_velocity: Vector2
var ball_origin:Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.scale = Vector2(MIN_BASEBALL_SCALE, MIN_BASEBALL_SCALE)
	timer.start()
	timer.connect("timeout", self, "on_timeout")
	ball_origin = global_position
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
		move_and_collide(current_velocity , false, true, false)
		if (global_position.y > BOTTOM_DESTROY_BOUNDS || 
			global_position.y < TOP_DESTROY_BOUNDS ||
			global_position.x < LEFT_DESTROY_BOUNDS ||
			global_position.x > RIGHT_DESTROY_BOUNDS):
			delete_ball()

func addVelocity( vel : Vector2 ):
	current_velocity = vel;
	

func on_timeout():
	sprite.scale = Vector2(
		sprite.scale.x +BASEBALL_SCALE_STEP,
		sprite.scale.y + BASEBALL_SCALE_STEP)
	if sprite.scale.x > MAX_BASEBALL_SCALE :
		sprite.scale = Vector2(MAX_BASEBALL_SCALE,MAX_BASEBALL_SCALE)
	current_velocity = current_velocity * BASEBALL_VELOCITY_SCALER_STEP

func delete_ball():
	BaseballEventsSingleton.emit_signal("destroy_background_baseball",global_position, current_velocity)
	queue_free()
