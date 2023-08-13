extends NpcCar

var rocket = load("res://npcs/rocket.tscn")
self.shooting = true
func shoot():
	if shooting:
		vaelf.add_child(projectile)
