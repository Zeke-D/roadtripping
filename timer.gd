extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer: Timer = Timer.new()
	var time_to_wait = randi() % 2
	timer.set_wait_time(time_to_wait)
	timer.set_one_shot(false)
	add_child(timer)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
