extends Sprite2D

var player
var threshold = 0

func _ready():
	player = get_tree().current_scene.find_child("Car")
	if self.is_in_group("hp1"):
		threshold = 1
	elif self.is_in_group("hp2"):
		threshold = 2
	elif self.is_in_group("hp3"):
		threshold = 3

func _physics_process(delta):
	if player.state < threshold:
		self.hide()
	else:
		self.show()
