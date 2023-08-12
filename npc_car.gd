extends CharacterBody2D

var player
const NPC_BASE_MOVEMENT_SPEED: float = 80


func _ready():
	player = get_tree().current_scene.find_child('Car')

func _physics_process(delta):
	position.y += player.player_vertical_speed - (NPC_BASE_MOVEMENT_SPEED * delta)
