class_name WrappingBackgroundElement
extends BackgroundElement

var INITIAL_OFFSET: float;

func _ready():
	INITIAL_OFFSET = self.position.y
	init()
	
func _physics_process(delta):
	self.position.y = next_position(delta)
	if (self.position.y > 600 + INITIAL_OFFSET):
		self.position.y = INITIAL_OFFSET



func _on_traffic_timer_timeout():
	pass # Replace with function body.
