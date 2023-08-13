extends Button

func _ready():
	get_tree().current_scene.find_child("menu_music").play()

func _on_pressed():
	get_tree().current_scene.find_child("menu_music").stop()
	get_tree().change_scene_to_file("res://Main Scenes/world.tscn")
