extends Control


func _on_button_pressed():
	global.boost_multiplier = global.BOOST_MULT_DEFAULT
	global.break_multiplier = global.BREAK_MULT_DEFAULT
	global.player_health = 3
	get_tree().change_scene_to_file("res://world.tscn")
