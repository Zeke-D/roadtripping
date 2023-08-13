extends CharacterBody2D
class_name NpcCar
var player
@export var speed: int = 80

func _ready():
	player = get_tree().current_scene.find_child('Car')

func _physics_process(delta):
	position.y += player.player_vertical_speed - (speed * delta)
