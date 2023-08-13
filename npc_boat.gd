extends NpcCar

var cannonballs: PackedScene = load("res://npcs/cannonballs.tscn")

func _ready():
	player = get_tree().current_scene.find_child('Car')
	self.add_to_group("Spinner")
	self.shooting = true
	
func shoot():
	var projectiles = cannonballs.instantiate()

	self.add_child(projectiles)

func _on_projectile_timer_timeout():
	if self.shooting:
		shoot()
