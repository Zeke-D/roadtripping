extends Button


func _on_pressed():
	global.player_health = 3
	get_tree().change_scene_to_file("res://Main Scenes/world.tscn")
