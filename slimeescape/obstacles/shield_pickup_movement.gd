extends CharacterBody2D


const JUMP_VELOCITY = -4500.0
const gravity = 4500
var virtSpeed = 0
const virtAccel = 12000
var direction : bool = true

func _physics_process(delta):
	if direction == true:
		virtSpeed = clampf(virtSpeed + virtAccel * delta, JUMP_VELOCITY, gravity)
	if direction == false:
		virtSpeed = clampf(virtSpeed - virtAccel * delta, JUMP_VELOCITY, gravity)
	
	if position.y <= 59:
		direction = true
	if position.y >= 109:
		direction = false

	velocity.y = virtSpeed * delta
	velocity.x = $"../../Player".speed/2 * delta
	move_and_slide()
