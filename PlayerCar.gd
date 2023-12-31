extends CharacterBody2D

const BASE_PLAYER_SPEED: Vector2 = Vector2(250, 300)
var player_vertical_speed: float = 200
var world 
var CAR_WIDTH : float = 32;
var ROAD_WIDTH : float = 49 * 4 - CAR_WIDTH;
var elapsed = 0.0
var spin_duration = 1.5

enum CarState {
	DEAD,
	ONE_LIFE,
	TWO_LIFE,
	FULL_HP,
}

enum World_Scroll_Speed {
	FAST,
	MEDIUM,
	SLOW,
	LENGTH
}

var hurtbox;

func _ready():
	get_tree().current_scene.find_child("Sounds").find_child("Idle_sound").play()
	global.distance = 0
	
	world = get_tree().current_scene
	hurtbox = find_child("Hurtbox")

func move(delta):
	var speed_mult = 1
	
	var new_x_pos = position.x
	
	if (Input.is_action_pressed("left")):
		new_x_pos -= BASE_PLAYER_SPEED.x * delta
	if (Input.is_action_pressed("right")):
		new_x_pos += BASE_PLAYER_SPEED.x * delta
	if (Input.is_action_pressed("up")):
		speed_mult = global.boost_multiplier
	if (Input.is_action_pressed("down")):
		speed_mult = global.break_multiplier
	
	new_x_pos = clamp(new_x_pos, ROAD_WIDTH / -2, ROAD_WIDTH / 2);
	
	# will come back to u
	# self.set_rotation(1/4 * PI * sin(elapsed))
	#elapsed += delta
	self.player_vertical_speed = BASE_PLAYER_SPEED.y * delta * speed_mult
	global.distance += self.player_vertical_speed
	self.find_child('ScoreText').text = str(int(global.distance / 1000))
	self.position.x = new_x_pos

func _physics_process(delta):
	if global.player_health == CarState.DEAD:
		self.player_vertical_speed = 0
	else:
		move(delta)

func move_and_rotate(target_position, target_rotation, duration):
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # So that the below tweens happen at the same time, not move then rotate
	tween.tween_property(self, "global_position", target_position, duration)
	tween.tween_property(self, "rotation", target_rotation, duration)
	tween.tween_callback(test).set_delay(duration)

func test():
	get_tree().current_scene.start_game_over()

func spinout(direction):
	get_tree().current_scene.find_child("Sounds").find_child("Idle_sound").stop()
	get_tree().current_scene.find_child("Sounds").find_child("Death_sound").play()
	move_and_rotate(direction * Vector2(1200, 600) * .25, 
		self.rotation + TAU * 2.64, spin_duration)


func take_damage(body):
	
	if body.is_in_group("Police"):
		global.player_health = CarState.DEAD
	
	if body.is_in_group("Civilian") and !global.police_chase:
		get_tree().current_scene.find_child("Spawner").spawn_cop()
	
	if body.is_in_group("Enemy"):
		print("HIT")
		get_tree().current_scene.find_child("Sounds").find_child("Car_hit").play()
		global.player_health -= 1
	
	if body.is_in_group("Spinner"):
		body.spinout((body.position - self.position).normalized())
	if body.is_in_group("Projectile"):
		global.player_health -= 1
		body.queue_free()
		body.get_parent().queue_free()
	if body.is_in_group("Projectile_Single"):
		global.player_health -= 1
		body.queue_free()
		body.get_parent().queue_free()
	if global.player_health == CarState.DEAD:
		self.spinout(-(body.position - self.position).normalized())
