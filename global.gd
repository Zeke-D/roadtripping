extends Node


var distance = 0
var police_chase = false
var level = 0
var npc_car_blue: PackedScene = load("res://npcs/npc_car_blue.tscn")
var npc_car_purple: PackedScene = load("res://npcs/npc_car_purple.tscn")
var npc_boat: PackedScene = load("res://npcs/npc_boat.tscn")
var npc_tank: PackedScene = load("res://npcs/npc_tank.tscn")
var npc_taxi: PackedScene = load("res://npcs/npc_taxi.tscn")
var npc_cop: PackedScene = load("res://npcs/npc_car_cop.tscn")
var alien: PackedScene = load("res://npcs/alien_ship.tscn")

var level_one_enemies: Dictionary = {
	npc_car_blue: 40,
	npc_car_purple: 40,
	npc_taxi: 20,
}
var level_two_enemies: Dictionary = {
	npc_cop: 100,
}

var level_three_enemies : Dictionary = {
	npc_car_blue: 30,
	npc_car_purple: 30,
	npc_taxi: 20,
	npc_tank: 20,
}

var level_four_enemies : Dictionary = {
	npc_car_blue: 20,
	npc_car_purple: 20,
	npc_taxi: 20,
	npc_tank: 20,
	npc_boat: 20,
}

var level_five_enemies : Dictionary = {
	npc_car_blue: 20,
	npc_car_purple: 20,
	npc_taxi: 10,
	npc_tank: 10,
	npc_boat: 20,
	alien: 20,
}

var LEVEL_ONE   = Level.new( 5000,  "Grass", level_one_enemies)
var LEVEL_TWO   = Level.new( 5000,  "Grass", level_two_enemies)
var LEVEL_THREE = Level.new(10000, "Desert", level_three_enemies)
var LEVEL_FOUR  = Level.new(10000, "Desert", level_four_enemies)
var LEVEL_FIVE  = Level.new(10000, "Desert", level_five_enemies)

var levels = [LEVEL_ONE, LEVEL_TWO, LEVEL_THREE, LEVEL_FOUR, LEVEL_FIVE]
