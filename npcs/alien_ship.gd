extends Node2D

@export var num_attacks = 3

var anim_mgr
var ship_state : ShipState
var player

enum ShipState {
	Enter,
	Attack,
	Leave
}

func move_and_rotate(target_position, target_rotation, duration):
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # So that the below tweens happen at the same time, not move then rotate
	tween.tween_property(self, "global_position", target_position, duration)
	tween.tween_property(self, "rotation", target_rotation, duration)
	return tween

func fly_out():
	move_and_rotate(Vector2(-100, -500), 0, 1)

func fly_to_car():
	move_and_rotate(Vector2(player.position.x, -100), 0, 0.3)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.find_child('Car')
	anim_mgr = self.find_child("AnimationPlayer")
	var fly_duration = 1
	var fly_car_duration = 0.3
	var attack_dur = 1.5
	var fly_in_tween = move_and_rotate(Vector2(player.position.x, -100), 0, fly_duration)
	for i in range(num_attacks):
		fly_in_tween.tween_callback(attack).set_delay(fly_duration + attack_dur * i + fly_car_duration * i)
		fly_in_tween.tween_callback(fly_to_car).set_delay(fly_duration + attack_dur * (i + 1) + fly_car_duration * i)
	fly_in_tween.tween_callback(fly_out).set_delay(
		fly_duration + attack_dur * num_attacks + fly_car_duration * (num_attacks - 1))

func attack():
	anim_mgr.queue("Zap")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
