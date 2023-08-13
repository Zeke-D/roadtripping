extends Node2D

var distance = 0
var goal_distance = 10000
var last_highway_sign = 0;

var highway_sign : PackedScene;
var background_root : Node2D

func _ready():
	highway_sign = load("res://highway_sign.tscn");
	background_root = self.find_child("Background")

func _physics_process(delta):
	
	# goal: every 1000m, give a highway sign
	if (distance - last_highway_sign > 1000):
		# make a sign
		var new_sign = highway_sign.instantiate()
		new_sign.position = Vector2(100, -500);
		new_sign.scale = Vector2(.5, .5);
		new_sign.mile_text = str(int(goal_distance - distance) / 1000) + " mi."
		get_tree().current_scene.add_child(new_sign)
		new_sign.init()
		last_highway_sign = distance
		
	
	if (distance >= goal_distance):
		print('win')
