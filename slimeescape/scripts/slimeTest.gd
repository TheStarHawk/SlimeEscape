extends CharacterBody2D

const maxSpeed : int = 10000
const minSpeed : int = 2000
var speed : float = 2000
var accel : float = 250
const JUMP_VELOCITY = -4000.0
const gravity = 4000

enum State {NORMAL, VEHICLE, DEAD, GAMEOVER}
var state = State.NORMAL

func updateAnim():
	match state:
		State.NORMAL:
			if not is_on_floor():
				$AnimatedSprite2D.animation = "air"
				if Input.is_action_pressed("Action"):
					$AnimatedSprite2D.frame = 0
				else:
					$AnimatedSprite2D.frame = 1
			else:
				$AnimatedSprite2D.play("ground")
				
		State.DEAD:
			if not is_on_floor():
				$AnimatedSprite2D.animation = "air"
				$AnimatedSprite2D.frame = 1
			else:
				$AnimatedSprite2D.play("dead")
				if $AnimatedSprite2D.frame == 3:
					state = State.GAMEOVER
					
		State.GAMEOVER:
			$AnimatedSprite2D.animation = "dead"
			$AnimatedSprite2D.frame = 3
			$"../UI/GameOverScreen".visible = true

func _physics_process(delta: float) -> void:
	updateAnim()
	match state:
		State.NORMAL:
			# Add the gravity.
			if not is_on_floor() and not Input.is_action_pressed("Action"):
				velocity.y = gravity * delta

			# Handle jump.
			if Input.is_action_pressed("Action"):
				velocity.y = JUMP_VELOCITY * delta
				
			speed = clampf(speed + accel * delta, minSpeed, maxSpeed)
			velocity.x = speed * delta

			move_and_slide()
			
		State.DEAD:
			if not is_on_floor():
				velocity.y = gravity * delta
				velocity.x = (speed * .75) * delta
				$Camera2D.position.x = move_toward($Camera2D.position.x, 0, .75)
			else:
				velocity.x = 0
			move_and_slide()
	
func die():
	state = State.DEAD
	
func hurt():
	if $Shield.visible == true:
		$Shield.visible = false
	else:
		die()
		
func shieldGet():
	if $Shield.visible == false:
		$Shield.visible = true
	else:
		pass
