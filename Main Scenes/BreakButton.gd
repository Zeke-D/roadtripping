extends Button


func _on_pressed():
	global.break_multiplier -= 0.1
	get_tree().change_scene_to_file("res://Main Scenes/world.tscn")

