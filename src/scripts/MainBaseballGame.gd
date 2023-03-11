extends Node2D

# Game Manger 


signal launch_baseball


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("launch_baseball")
