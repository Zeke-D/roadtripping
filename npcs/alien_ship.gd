extends Node2D

@export var num_attacks = 3

var anim_mgr
var ship_state : ShipState

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

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_mgr = self.find_child("AnimationPlayer")
	var fly_duration = 1
	var attack_dur = 1.5
	var fly_in_tween = move_and_rotate(Vector2(0, -100), 0, fly_duration)
	fly_in_tween.tween_callback(attack).set_delay(fly_duration)
	fly_in_tween.tween_callback(fly_out).set_delay(
		2 * fly_duration + attack_dur * num_attacks)

func attack():
	for i in range(num_attacks):
		anim_mgr.queue("Zap")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
