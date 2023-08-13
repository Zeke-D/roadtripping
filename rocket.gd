extends CharacterBody2D
class_name Rocket

@export var rocket_speed = 220;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = self.position + Vector2(0, -1) * rocket_speed * delta
