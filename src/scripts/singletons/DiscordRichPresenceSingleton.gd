# Note: the node that's loading this Singleton needs to be processed *after* the 
# the Discord singleton. This can be checked by doing Project -> Project Settings
# -> Autoloads 

# Make sure that this singleton shows up lower on the list than the Discord singleton.

extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	BaseballEventsSingleton.connect("score_updated", self, "_on_BaseballEventsSingleton_score_updated")
	update_activity(0)

func update_activity(score: int) -> void:
	var activity = Discord.Activity.new()
	activity.set_type(Discord.ActivityType.Playing)
	activity.set_state("Being the Spaceball Bat of my dreams")
	activity.set_details("Current score: %s" % score)

	var assets = activity.get_assets()
	# the images are hosted online on the
	# Spaceball Bat discord application in Discord's
	# developer console. the value we pass in is the
	# key of the art asset that we give it in the
	# developer console. 
	assets.set_small_image("bat_discord_small_icon")
	
	# this the hover text if somebody hovers
	# over the icon that shows up on the 
	# Discord profile.
	assets.set_small_text("SPACEBALL BAT")
	
#   timestamps are behaving unexpectedly since
#   setting a start time doesn't seem to cause 
#   it to automatically update how much time
#   has elasped so leaving this commented out
#   for now. 
#	var timestamps = activity.get_timestamps()
#	timestamps.set_start(OS.get_unix_time() + 100)
	
	# yields tend to have some bugginess in Godot 3. this code came from the examples from the
	# plugin and seems to be working. if we encounter any significant issues it's a good 
	# argument to start looking at porting over to Godot 4. 
	var result = yield(Discord.activity_manager.update_activity(activity), "result").result
	if result != Discord.Result.Ok:
		push_error(result)

func _on_BaseballEventsSingleton_score_updated(score: int):
	update_activity(score)
