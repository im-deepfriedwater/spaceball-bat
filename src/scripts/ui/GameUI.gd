extends Control

func _ready():
	BaseballEventsSingleton.connect("game_over", self, "on_BaseballEventsSingleton_game_over")
	
func on_BaseballEventsSingleton_game_over(score):
	visible = false
