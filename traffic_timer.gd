extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	var time_to_wait = randi() % 3 + 1
	self.wait_time = time_to_wait
	self.set_one_shot(false)
	add_child(self)
	self.start()
