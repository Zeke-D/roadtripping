class_name BackgroundElement
extends Node2D

var player

var INITIAL_OFFSET

enum World_Scroll_Speed {
	FAST,
	MEDIUM,
	SLOW
}

func _ready():
	player = get_tree().current_scene.find_child('Car')
	INITIAL_OFFSET = position.y

func _physics_process(delta):
	position.y = position.y + player.player_vertical_speed
	if (position.y > 600 + INITIAL_OFFSET):
		position.y = INITIAL_OFFSET
