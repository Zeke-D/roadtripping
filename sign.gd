extends BackgroundElement

var distance_label : Label
var mile_text : String

# Called when the node enters the scene tree for the first time.
func _ready():
	distance_label = self.find_child("mile_marker")
	distance_label.text = mile_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# delete when offscreen
	if (self.position.y > 200):
		self.free()
