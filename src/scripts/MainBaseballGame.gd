extends Node2D

export var MAX_BASEBALL_COUNT := 10

onready var launch_timer := $LaunchTimer
onready var score_ui := $CanvasLayer/Score

var rng := RandomNumberGenerator.new()

var baseball_count := 0
var score := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	BaseballEventsSingleton.connect("catch_baseball", self, "_on_BaseballEventsSingleton_catch_baseball")
	BaseballEventsSingleton.connect("destroy_baseball", self, "_on_BaseballEventsSingleton_destroy_baseball")
	set_random_launch_time()
	launch_timer.start()

func set_random_launch_time():
	launch_timer.wait_time = rng.randi_range(1, 5)
	
func _on_LaunchTimer_timeout():
	if baseball_count < MAX_BASEBALL_COUNT:
		BaseballEventsSingleton.emit_signal("launch_baseball")
		baseball_count += 1
		set_random_launch_time()
		launch_timer.start()

func _on_BaseballEventsSingleton_launch_baseball():
	baseball_count += 1

func _on_BaseballEventsSingleton_catch_baseball():
	score += 100
	score_ui.set_score(score)
	BaseballEventsSingleton.emit_signal("score_updated", score)

func _on_BaseballEventsSingleton_destroy_baseball():
	baseball_count -= 1
	
	
