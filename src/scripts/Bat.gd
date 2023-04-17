extends KinematicBody2D

enum MovementType {
	Linear,
	Flappy
}

var current_movement_type = MovementType.Linear

# Probably going to break this out into a state machine
# to break this out a little more
# Flappy Movement Region
export var flappy_vertical_max_speed: float =  55
export var flappy_gravity: float = 105
export var flappy_input_buffer_in_seconds: float = 0.05
# export var flappy_input_buffer_in_seconds: float = 0.30
export var flappy_horizontal_impulse: float = 35
export var flappy_horizontal_max_speed: float = 90
export var flappy_horizontal_acceleration: float = 100
export var flappy_friction: float = 60
export var flappy_is_horizontal_momentum: bool = false
onready var flappy_input_buffer_timer := $FlappyInputBufferTimer
var flappy_is_input_buffering : bool = false
# Flappy Movement End Region

onready var animation_tree := $AnimationTree

var bat_velocity := Vector2.ZERO
var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	flappy_input_buffer_timer.wait_time = flappy_input_buffer_in_seconds
	current_movement_type = MovementType.Flappy
	
	animation_tree.set("parameters/OneShot/active", true)
	
func _process(delta: float):
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	match current_movement_type:
		MovementType.Linear:
			handle_linear_movement(delta, input_vector)
			
		MovementType.Flappy:
			handle_flappy_movement(delta, input_vector)
	
# TODO fill in here
func handle_linear_movement(delta: float, input_vector: Vector2):
	pass

func handle_flappy_movement(delta: float, input_vector: Vector2):
	var horizontal_velocity = Vector2(bat_velocity.x, 0)
	var horizontal_input_vector = Vector2(input_vector.x, 0)
	
	# keep gravity consistent between framerates
	bat_velocity.y += delta * flappy_gravity

	if !flappy_is_input_buffering and Input.is_action_just_pressed("ui_accept"):
		bat_velocity.y += -flappy_vertical_max_speed
		#bat_velocity.y = -flappy_vertical_max_speed
		flappy_is_input_buffering = true
		flappy_input_buffer_timer.start()

		
	if flappy_is_horizontal_momentum:
		if horizontal_input_vector != Vector2.ZERO:
			horizontal_velocity = horizontal_velocity.move_toward( \
				horizontal_input_vector * flappy_horizontal_max_speed, \
				flappy_horizontal_acceleration * delta)
	else:
		if Input.is_action_pressed("ui_left"):
			horizontal_velocity.x = -flappy_horizontal_max_speed
		elif Input.is_action_pressed("ui_right"):
			horizontal_velocity.x = flappy_horizontal_max_speed
		else:
			horizontal_velocity.x = 0
	
	bat_velocity = Vector2(horizontal_velocity.x, bat_velocity.y)
	
	move()
	
func move():
	# in Godot, upward is negative y, which translates to -1 as a normal
	bat_velocity = move_and_slide(bat_velocity, Vector2(0, -1))

	var blend_position := -1 if bat_velocity.y <= 0 else 1
	animation_tree.set("parameters/WingBlendSpace/blend_position", blend_position)

	
func _on_InputBufferTimer_timeout():
	flappy_is_input_buffering = false
