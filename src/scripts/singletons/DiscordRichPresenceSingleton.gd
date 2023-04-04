extends Node


# todo we'll probably to 
# connect this to a persistent
# high score system
var highest_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	BaseballEventsSingleton.connect("score_updated", self, "_on_BaseballEventsSingleton_score_updated")
	update_activity(0)

func update_activity(score: int) -> void:
	highest_score = max(highest_score, score)
	
	var activity = Discord.Activity.new()
	activity.set_type(Discord.ActivityType.Playing)
	activity.set_state("Whoever is reading this smells.")
#	"Score: %s" % new_score
	activity.set_details("High Score: %s | Current score: %s" % [highest_score, score])

	var assets = activity.get_assets()
#	assets.set_large_image("zone2")
#	assets.set_large_text("ZONE 2 WOOO")
#	assets.set_small_image("capsule_main")
	assets.set_small_text("SPACEBALL BAT")

	var result = yield(Discord.activity_manager.update_activity(activity), "result").result
	if result != Discord.Result.Ok:
		push_error(result)

func _on_BaseballEventsSingleton_score_updated(score: int):
	update_activity(score)
