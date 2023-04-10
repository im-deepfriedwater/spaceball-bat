extends Control

onready var animation_player = $AnimationPlayer
onready var score_end_text = get_node("%ScoreEndText")

var current_scene = null

var is_ready_for_restart := false

# https://docs.godotengine.org/en/3.5/tutorials/scripting/singletons_autoload.html#custom-scene-switcher
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	BaseballEventsSingleton.connect("game_over", self, "on_BaseballEventsSingleton_game_over")

func _unhandled_input(event):
	if !is_ready_for_restart:
		return

	if !is_ready_for_restart and Input.is_action_just_pressed("ui_select"):
		animation_player.play("ShowSkip")
	elif is_ready_for_restart and Input.is_action_just_pressed("ui_select"):
		SceneSwitcherSingleton.goto_scene(SceneEnum.Scenes.MainBaseballGame)
		
func on_BaseballEventsSingleton_game_over(score):
	score_end_text.text = "Score: %s" % score
	animation_player.play("Show")

func anim_on_show_finished():
	is_ready_for_restart = true
