extends Node2D

# Game Manger 

signal launch_baseball

# baseballs will tell
# the game manager to
# emit this signal
signal baseball_caught

export var MAX_BASEBALL_COUNT := 10

onready var launch_timer := $LaunchTimer

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_launch_time()
	launch_timer.start()

func set_random_launch_time():
	launch_timer.wait_time = rng.randi_range(1, 5)
	
func _on_LaunchTimer_timeout():
	emit_signal("launch_baseball")
	set_random_launch_time()
	launch_timer.start()

