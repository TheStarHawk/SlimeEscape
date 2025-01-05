extends CharacterBody2D

const maxSpeed : int = 6000
const minSpeed : int = 2000
var speed : float = 2000
var accel : float = 250
const JUMP_VELOCITY = -4500.0
const gravity = 4500
var virtSpeed = 0
const virtAccel = 12000

enum State {NORMAL, VEHICLE, DEAD, GAMEOVER}
var state = State.NORMAL
var hurted : bool = false

func updateAnim():
	match state:
		State.NORMAL:
			if not is_on_floor():
				$AnimatedSprite2D.animation = "air"
				if Input.is_action_pressed("Action"):
					$AnimatedSprite2D.frame = 0
					$Near.position = Vector2(10, -13)
				else:
					$AnimatedSprite2D.frame = 1
					$Near.position = Vector2(8, -12)
			else:
				$AnimatedSprite2D.play("ground")
				$Near.position = Vector2(7, -11)
				
		State.DEAD:
			if not is_on_floor():
				$AnimatedSprite2D.animation = "air"
				$AnimatedSprite2D.frame = 1
				if $Sounds/Fall.playing == false:
					$Sounds/Fall.play()
			else:
				$Sounds/Fall.stop()
				$AnimatedSprite2D.play("dead")
				if $AnimatedSprite2D.frame == 1:
					if$Sounds/POP.playing == false:
						$Sounds/POP.pitch_scale = 0.4
						$Sounds/POP.play()
				if $AnimatedSprite2D.frame == 3:
					state = State.GAMEOVER
					
		State.GAMEOVER:
			$AnimatedSprite2D.animation = "dead"
			$AnimatedSprite2D.frame = 3

func _physics_process(delta: float) -> void:
	updateAnim()
	match state:
		State.NORMAL:
			# Add the gravity.
			if not is_on_floor() and not Input.is_action_pressed("Action"):
				if is_on_ceiling():
					virtSpeed = 0
				virtSpeed = clampf(virtSpeed + virtAccel * delta, JUMP_VELOCITY, gravity)

			# Handle jump.
			if Input.is_action_pressed("Action"):
				if is_on_floor():
					virtSpeed = 0
				virtSpeed = clampf(virtSpeed - virtAccel * delta, JUMP_VELOCITY, gravity)
			
			if Input.is_action_just_pressed("Action"):
				$Sounds/Jump.pitch_scale = randi_range(9, 11)/10
				$Sounds/Jump.play()
				
			speed = clampf(speed + accel * delta, minSpeed, maxSpeed)
			velocity.x = speed * delta
			velocity.y = virtSpeed * delta
			
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
	$EndTimer.start()
	
func hurt():
	hurted = true
	$HurtTimer.start()
	if $Shield.visible == true:
		$Shield.visible = false
		$Sounds/POP.pitch_scale = 0.6
		$Sounds/POP.play()
	else:
		die()
		
func shieldGet():
	if $Shield.visible == false:
		$Shield.visible = true
		$Sounds/Shield.play()
	else:
		$"..".score += 50
		
func pelletGet():
	$"..".pelletGet()

func _on_end_timer_timeout():
	$"..".endGame()

func _on_timer_timeout():
	$Near.visible = false

func _on_hurt_timer_timeout():
	hurted = false
