extends Node2D


enum MovementType {
	Linear,
	Flappy
}

var current_movement_type = MovementType.Linear


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta: float):
	match current_movement_type:
		
		MovementType.Linear:
			handle_linear_movement()
			
			
			
		MovementType.Flappy:
			handle_flappy_movement()
		
	
# TODO fill in here
func handle_linear_movement():
	pass











# TODO
func handle_flappy_movement():
	pass
