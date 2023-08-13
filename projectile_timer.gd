extends Timer
@export var lower_bounds: int = 2
@export var upper_bounds: int = 5
var shooting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if shooting:
		var time_to_wait = (randi() % (upper_bounds - lower_bounds)) + lower_bounds
		self.set_one_shot(false)
		add_child(self)
		self.start(time_to_wait)
