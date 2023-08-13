extends NpcCar

var cannonballs: PackedScene = load("res://npcs/cannonballs.tscn")
var shooting = true
func shoot():
	var projectiles = cannonballs.instantiate()

	self.add_child(projectiles)

func _on_projectile_timer_timeout():
	if shooting:
		shoot()
