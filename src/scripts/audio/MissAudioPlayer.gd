extends AudioStreamPlayer2D

func _ready():
	BaseballEventsSingleton.connect("miss_baseball", self, "on_BaseballEventsSingleton_miss_baseball")

func on_BaseballEventsSingleton_miss_baseball():
	play()
