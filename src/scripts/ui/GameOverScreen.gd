extends Control

var main_game_scene := preload("res://scenes/MainBaseballGame.tscn")
var current_scene = null

var is_game_over := false

# https://docs.godotengine.org/en/3.5/tutorials/scripting/singletons_autoload.html#custom-scene-switcher
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	BaseballEventsSingleton.connect("game_over", self, "on_BaseballEventsSingleton_game_over")

func _unhandled_input(event):
	if !is_game_over:
		return

	if Input.is_action_just_pressed("ui_select"):
		call_deferred(deferred_restart_game_scene())
		
func on_BaseballEventsSingleton_game_over():
	visible = true
	is_game_over = true

func deferred_restart_game_scene():
	current_scene.free()

	# Instance the new scene.
	current_scene = main_game_scene.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	


