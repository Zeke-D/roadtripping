extends CharacterBody2D

const BASE_PLAYER_SPEED: Vector2 = Vector2(200, 300)
var player_vertical_speed: float = 200
var world 
var CAR_WIDTH : float = 32;
var ROAD_WIDTH : float = 49 * 4 - CAR_WIDTH;
var elapsed = 0.0
var spin_duration = 2
var state = CarState.FULL_HP

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

var speed_mult_map : Array[float] = [];
var hurtbox;

func _ready():
	
	global.distance = 0
	
	#init speed_mult_map
	for i in range(World_Scroll_Speed.LENGTH):
		speed_mult_map.append(1.);
	speed_mult_map[World_Scroll_Speed.FAST]   = 2.0;
	speed_mult_map[World_Scroll_Speed.MEDIUM] = 1.0;
	speed_mult_map[World_Scroll_Speed.SLOW]   = 0.7;
	
	world = get_tree().current_scene
	hurtbox = find_child("Hurtbox")

func move(delta):
	var speed_mult = speed_mult_map[World_Scroll_Speed.MEDIUM]
	
	var new_x_pos = position.x
	
	if (Input.is_action_pressed("left")):
		new_x_pos -= BASE_PLAYER_SPEED.x * delta
	if (Input.is_action_pressed("right")):
		new_x_pos += BASE_PLAYER_SPEED.x * delta
	if (Input.is_action_pressed("up")):
		speed_mult = speed_mult_map[World_Scroll_Speed.FAST]
	if (Input.is_action_pressed("down")):
		speed_mult = speed_mult_map[World_Scroll_Speed.SLOW]
	
	new_x_pos = clamp(new_x_pos, ROAD_WIDTH / -2, ROAD_WIDTH / 2);
	
	# will come back to u
	# self.set_rotation(1/4 * PI * sin(elapsed))
	#elapsed += delta
	self.player_vertical_speed = BASE_PLAYER_SPEED.y * delta * speed_mult
	global.distance += self.player_vertical_speed
	self.find_child('ScoreText').text = str(int(global.distance / 1000))
	self.position.x = new_x_pos

func _physics_process(delta):
	if state == CarState.DEAD:
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
	move_and_rotate(direction * Vector2(1200, 600) * .25, 
		self.rotation + TAU * 2.64, spin_duration)

func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy") and state != CarState.DEAD:
		print("HIT")
		state -= 1
		body.spinout((body.position - self.position).normalized())
		if state == CarState.DEAD:
			self.spinout(-(body.position - self.position).normalized())
<<<<<<< Updated upstream
			
	if body.is_in_group("Police") and state != CarState.DEAD:
		state = 0
		self.spinout(-(body.position - self.position).normalized())
=======
	if body.is_in_group("Projectile"):
		print("AHHHHH")
		body.queue_free()
>>>>>>> Stashed changes
