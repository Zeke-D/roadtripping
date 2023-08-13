extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.wait_time = global.levels[global.level].spawn_seconds
	self.set_one_shot(false)
	add_child(self)
	self.start()

func _process(delta):
	var player_speed_mult = get_tree().current_scene.find_child('Car').speed_mult
	self.wait_time = global.levels[global.level].spawn_seconds / player_speed_mult
