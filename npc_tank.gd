extends NpcCar

var rocket = load("res://npcs/rocket.tscn")

func shoot():
	var projectile = rocket.instantiate()
	self.add_child(projectile)
