extends Node2D

var WIDTH: int = 50
var LANE_ONE_X: int = -73
var LANE_ONE: Vector2 = Vector2(LANE_ONE_X, -500)

func get_lane(lane_index: int):
	return LANE_ONE + lane_index * Vector2(WIDTH, 0)
	
func get_obstacle(index):
	var acc = 0
	for obstacle in global.levels[global.level].npc_dict:
		acc = acc + global.levels[global.level].npc_dict[obstacle]
		if index <= acc:
			return obstacle

func create_obstacle(pos, obstacle):
	var npcCar = obstacle.instantiate()
	npcCar.position = pos
	get_parent().add_child(npcCar)

func spawn_cop(pos):
	var npcCar = global.npc_cop.instantiate()
	npcCar.position = pos
	get_parent().add_child(npcCar)

func _on_traffic_timer_timeout():
	var lane_to_spawn = randi() % 4
	var rand_obstacle = randi() % 100
	create_obstacle(get_lane(lane_to_spawn), get_obstacle(rand_obstacle))
