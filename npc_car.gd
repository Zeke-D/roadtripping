extends CharacterBody2D
class_name NpcCar
var player
@export var speed: int


# spin globals
var did_spin = false
var spin_duration = 2.

func get_next_position(delta):
	if did_spin:
		return self.position + Vector2(0, player.player_vertical_speed)
		
	return self.position + Vector2(
		0, 
		player.player_vertical_speed - speed * delta
	)

func _ready():
	player = get_tree().current_scene.find_child('Car')

func _physics_process(delta):
	position = get_next_position(delta)

func move_and_rotate(target_position, target_rotation, duration):
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # So that the below tweens happen at the same time, not move then rotate
	tween.tween_property(self, "global_position", target_position, duration)
	tween.tween_property(self, "rotation", target_rotation, duration)


func spinout(direction):
	print("SPIN")
	did_spin = true
	self.find_child("CollisionShape2D").set_deferred("disabled",true)
	# deactivate collider
	move_and_rotate(direction * Vector2(1200, 600) * .5, self.rotation + TAU * 4, spin_duration)
	if self.shooting:
		self.shooting = false
