extends CharacterBody2D
class_name Cannonball
var boat
enum SIDE {
	LEFT,
	RIGHT
}
@export var side: SIDE

const CANNON_BALL_SPEED: float = 70

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match side:
		SIDE.LEFT:
			position = get_parent().position + self.position + Vector2(CANNON_BALL_SPEED * delta, 0)
		SIDE.RIGHT:
			position = get_parent().position + self.position + Vector2(-CANNON_BALL_SPEED * delta, 0)
