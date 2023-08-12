extends CharacterBody2D

const BASE_PLAYER_SPEED: Vector2 = Vector2(200, 200)
var player_vertical_speed: float = 200

var CAR_WIDTH : float = 32;
var ROAD_WIDTH : float = 32 * 10 - CAR_WIDTH;

enum World_Scroll_Speed {
	FAST,
	MEDIUM,
	SLOW,
	LENGTH
}

var speed_mult_map : Array[float] = [];
var hurtbox;

func _ready():
	
	#init speed_mult_map
	for i in range(World_Scroll_Speed.LENGTH):
		speed_mult_map.append(1.);
	speed_mult_map[World_Scroll_Speed.FAST]   = 1.5;
	speed_mult_map[World_Scroll_Speed.MEDIUM] = 1.0;
	speed_mult_map[World_Scroll_Speed.SLOW]   = 0.7;
	
	hurtbox = find_child("Hurtbox")


func _physics_process(delta):
	
	var speed_mult = speed_mult_map[World_Scroll_Speed.MEDIUM]
	
	var new_pos = position
	
	if (Input.is_action_pressed("left")):
		new_pos.x -= BASE_PLAYER_SPEED.x * delta
	if (Input.is_action_pressed("right")):
		new_pos.x += BASE_PLAYER_SPEED.x * delta
	if (Input.is_action_pressed("up")):
		speed_mult = speed_mult_map[World_Scroll_Speed.FAST]
	if (Input.is_action_pressed("down")):
		speed_mult = speed_mult_map[World_Scroll_Speed.SLOW]
	
	new_pos.x = clamp(new_pos.x, ROAD_WIDTH / -2, ROAD_WIDTH / 2);
	
	# check collisions
	var should_move_horizontal : bool = true
	var should_move_vertical   : bool = true
	for body in hurtbox.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			should_move_horizontal = abs(body.position - self.position).x <= 32
			should_move_vertical = 0 <= (body.position - self.position).y <= 64
	
	player_vertical_speed = 0
	if should_move_vertical:
		player_vertical_speed = BASE_PLAYER_SPEED.y * delta * speed_mult
	if should_move_horizontal:
		position = new_pos


func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy"):
		print("HIT")
		position += (position - body.position) / 10
