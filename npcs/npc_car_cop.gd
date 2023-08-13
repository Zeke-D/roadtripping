extends CharacterBody2D
class_name NpcCopCar
var player
@export var speed: int = 100000
const NPC_BASE_MOVEMENT_SPEED: float = 400
const NPC_INITIAL_CHASE_SPEED: float = 100000
const COP_HORIZONTAL_SPEED: float = 5
# spin globals
var did_spin = false
var spin_duration = 2.
var escape_tween
var offscreen = true
var initial_chase = true
func get_next_position(delta):
	if did_spin:
		return self.position + Vector2(0, player.player_vertical_speed)
		
	return Vector2(
		lerp(self.position.x, player.position.x - 16, COP_HORIZONTAL_SPEED * delta), 
		self.position.y + player.player_vertical_speed - speed * delta
	)

func _ready():
	player = get_tree().current_scene.find_child('Car')
	escape_tween = get_tree().create_tween()
	escape_tween.stop()
	global.police_chase = true
	get_tree().current_scene.find_child("Sounds").find_child("Police_sirens").play()

func _physics_process(delta):
	position = get_next_position(delta)
	check_offscreen()
	
	if position.y < -200:
		position = get_tree().current_scene.find_child("Car").position + Vector2(0, 400)

func check_offscreen():
	if(self.position.y > player.position.y + 400 and offscreen == false):
		escape_tween.tween_callback(escaped).set_delay(2)
		escape_tween.play()
		offscreen = true
	elif(self.position.y <= player.position.y + 400):
		if(initial_chase == true):
			initial_chase = false
			speed = NPC_BASE_MOVEMENT_SPEED
			
		offscreen = false
		escape_tween.stop()

func escaped():
	if(!initial_chase):
		global.police_chase = false
		self.queue_free()
		get_tree().current_scene.find_child("Sounds").find_child("Police_sirens").stop()

func move_and_rotate(target_position, target_rotation, duration):
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # So that the below tweens happen at the same time, not move then rotate
	tween.tween_property(self, "global_position", target_position, duration)
	tween.tween_property(self, "rotation", target_rotation, duration)


func spinout(direction):
	did_spin = true
	
	# deactivate collider
	move_and_rotate(direction * Vector2(1200, 600) * .5, self.rotation + TAU * 4, spin_duration)
	


func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy"):
		body.spinout((body.position - self.position).normalized())
		get_tree().current_scene.find_child("Sounds").find_child("Car_hit").play()
