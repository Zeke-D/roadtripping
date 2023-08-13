extends Node2D

var distance = 0
var goal_distance = 10000

func _physics_process(delta):
	if (distance >= goal_distance):
		print('win')
		
