extends CharacterBody2D

const maxSpeed : int = 10000
const minSpeed : int = 2000
var speed : float = 2000
var accel : float = 100
const JUMP_VELOCITY = -2000.0
const gravity = 2000

func updateAnim():
	if not is_on_floor():
		$AnimatedSprite2D.animation = "air"
		if Input.is_action_pressed("ui_accept"):
			$AnimatedSprite2D.frame = 0
		else:
			$AnimatedSprite2D.frame = 1
	else:
		$AnimatedSprite2D.play("ground")

func _physics_process(delta: float) -> void:
	updateAnim()
	# Add the gravity.
	if not is_on_floor() and not Input.is_action_pressed("ui_accept"):
		velocity.y = gravity * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY * delta
		
	speed = clampf(speed + accel * delta, minSpeed, maxSpeed)
	velocity.x = speed * delta

	move_and_slide()
