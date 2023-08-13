extends Node2D

var last_highway_sign = 0;

var highway_sign : PackedScene;
var background_root : Node2D
var count = 0
var game_over = false

func _ready():
	handle_background()
	global.police_chase = false
	highway_sign = load("res://highway_sign.tscn");
	background_root = self.find_child("Background")

func handle_background():
	
	var bg = self.find_child("CanvasGroup").find_child("Background")
	
	for bg_element in bg.get_children():
		bg_element.hide()	
	
	bg.find_child(global.levels[global.level].bg_name).show()
	bg.find_child("road").show()
	bg.find_child("road_2").show()
		
func _physics_process(delta):
	
	if (count % 10 == 0 && game_over == true):
		set_modulate(lerp(get_modulate(), Color(0,0,0,1), 0.2))
		
	count += 1
	# goal: every 1000m, give a highway sign
	if (global.distance - last_highway_sign > 1000):
		# make a sign
		var new_sign = highway_sign.instantiate()
		new_sign.position = Vector2(100, -500);
		new_sign.scale = Vector2(.5, .5);
		new_sign.mile_text = str(
			int(global.levels[global.level].distance - global.distance) / 1000
			) + " mi."
		get_tree().current_scene.add_child(new_sign)
		new_sign.init()
		last_highway_sign = global.distance
		
	
	if (global.distance >= global.levels[global.level].distance):
		get_tree().change_scene_to_file("res://Main Scenes/checkpoint.tscn")
		global.level += 1

func start_game_over():
	game_over = true
	var tween = get_tree().create_tween()
	tween.tween_callback(finish_game_over).set_delay(2)

func finish_game_over():
	get_tree().change_scene_to_file("res://Main Scenes/end_screen.tscn")
