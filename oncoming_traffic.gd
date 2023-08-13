extends Node2D



var WIDTH: int = 50
var LANE_ONE_X: int = -73

var npc_car_blue: PackedScene = load("res://npcs/npc_car_blue.tscn")
var npc_car_purple: PackedScene = load("res://npcs/npc_car_purple.tscn")
var npc_boat: PackedScene = load("res://npcs/npc_boat.tscn")
var npc_tank: PackedScene = load("res://npcs/npc_tank.tscn")
var npc_taxi: PackedScene = load("res://npcs/npc_taxi.tscn")

var LANE_ONE: Vector2 = Vector2(LANE_ONE_X, -500)

var obstacle_dict_2: Dictionary = {
	npc_car_blue: 30,
	npc_car_purple: 30,
	npc_taxi: 20,
	npc_tank: 5,
	npc_boat: 15
}

func get_lane(lane_index: int):
	return LANE_ONE + lane_index * Vector2(WIDTH, 0)
	
func get_obstacle(index):
	var acc = 0
	for obstacle in obstacle_dict_2:
		acc = acc + obstacle_dict_2[obstacle]
		if index <= acc:
			return obstacle

func create_obstacle(pos, obstacle):
	var npcCar = obstacle.instantiate()
	npcCar.position = pos
	get_parent().add_child(npcCar)

func _on_traffic_timer_timeout():
	var lane_to_spawn = randi() % 4
	var rand_obstacle = randi() % 100
	create_obstacle(get_lane(lane_to_spawn), get_obstacle(rand_obstacle))
