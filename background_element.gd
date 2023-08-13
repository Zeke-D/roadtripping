class_name BackgroundElement
extends Node2D

var player
enum World_Scroll_Speed {
	FAST,
	MEDIUM,
	SLOW
}

func _ready():
	init()
	
func init():
	player = get_tree().current_scene.find_child('Car')

func next_position(delta):
	return self.position.y + player.player_vertical_speed

func _physics_process(delta):
	self.position.y = next_position(delta)
