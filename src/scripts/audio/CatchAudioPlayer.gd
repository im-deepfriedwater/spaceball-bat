extends AudioStreamPlayer

func _ready():
	BaseballEventsSingleton.connect("catch_baseball", self, "on_BaseballEventsSingleton_catch_baseball")

func on_BaseballEventsSingleton_catch_baseball():
	play()
