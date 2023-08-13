extends Node2D

var distance = 0
var goal_distance = 10000
var last_highway_sign = 0;

var highway_sign : PackedScene;
var background_root : Node2D
var count = 0
var game_over = false

func _ready():
	highway_sign = load("res://highway_sign.tscn");
	background_root = self.find_child("Background")

func _physics_process(delta):
	
	if (count % 10 == 0 && game_over == true):
		set_modulate(lerp(get_modulate(), Color(0,0,0,1), 0.2))
		
	count += 1
	# goal: every 1000m, give a highway sign
	if (distance - last_highway_sign > 800):
		# make a sign
		var new_sign = highway_sign.instantiate()
		new_sign.position = Vector2(100, -500);
		new_sign.scale = Vector2(.5, .5);
		new_sign.mile_text = str(int(goal_distance - distance) / 1000)
		background_root.add_child(new_sign)
		
	
	if (distance >= goal_distance):
		print('win')

func start_game_over():
	game_over = true
	var tween = get_tree().create_tween()
	tween.tween_callback(test).set_delay(2)

func test():
	print("yo frfr")
