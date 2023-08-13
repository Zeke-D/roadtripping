extends NpcCar

var rocket = load("res://npcs/rocket.tscn")

func _ready():
	player = get_tree().current_scene.find_child('Car')
	self.add_to_group("Spinner")
	self.shooting = true
	
func shoot():
	var projectile = rocket.instantiate()
	if self.shooting:
		self.add_child(projectile)
