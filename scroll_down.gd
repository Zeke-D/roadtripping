extends Node2D

var player

enum World_Scroll_Speed {
	FAST,
	MEDIUM,
	SLOW
}

func _ready():
	player = get_tree().current_scene.find_child('Car')

func _physics_process(delta):
	position.y = position.y + player.player_vertical_speed
	if (position.y > 648/4):
		position.y = 0
