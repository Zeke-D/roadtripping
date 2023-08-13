extends Button


func _on_pressed():
	global.boost_multiplier = global.BOOST_MULT_DEFAULT
	global.break_multiplier = global.BREAK_MULT_DEFAULT
	global.player_health = 3
	global.level = 0
	get_tree().change_scene_to_file("res://Main Scenes/menu.tscn")
