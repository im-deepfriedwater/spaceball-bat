extends Node2D


enum MovementType {
	Linear,
	Flappy
}

var current_movement_type = MovementType.Linear

# Flappy Movement Region
export var flappy_impulse: float =  4
export var flappy_gravity: float = -9.8
export var flappy_buffer_in_seconds: float = 0.25
export var y_velocity : float = 0 

# Flappy Movement End Region

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta: float):
	match current_movement_type:
		
		MovementType.Linear:
			handle_linear_movement()
			
		MovementType.Flappy:
			handle_flappy_movement(delta)
		
	
# TODO fill in here
func handle_linear_movement():
	pass


# TODO"
func handle_flappy_movement(delta: float):
	if (Input.is_action_pressed("ui_accept")):
		pass
