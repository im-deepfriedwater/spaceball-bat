extends Node

var main_game_scene := preload("res://scenes/MainBaseballGame.tscn")

var current_scene = null
var is_game_over := false


# https://docs.godotengine.org/en/3.5/tutorials/scripting/singletons_autoload.html#custom-scene-switcher
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
		
func goto_scene(scene):
	match scene:
		SceneEnum.Scenes.MainBaseballGame:
			call_deferred("deferred_restart_game_scene", main_game_scene)

func deferred_restart_game_scene(scene):
	current_scene.free()

	# Instance the new scene.
	current_scene = scene.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)



