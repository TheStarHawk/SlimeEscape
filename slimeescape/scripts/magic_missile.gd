extends CharacterBody2D

enum State {WARNING, FIRE,BOOM}
var state = State.WARNING
var speed = -250

var tracking : bool = false
var soundW : bool = true
var soundM : bool = true
var soundB : bool = true

func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.WARNING:
			$Warning.play("default")
			if tracking == true:
				position.y = $"../../../Player".position.y
			position.x = $"../../../Player".position.x + 293 - $"..".position.x
		State.FIRE:
			if soundM == true:
				$WarningSoundTimer.stop()
				$MissileMove.play()
				$MoveSoundTimer.start()
				soundM = false
			$AnimatedSprite2D.visible = true
			$Warning.visible = false
			move_and_collide(Vector2(speed * delta, 0))
			$CollisionShape2D.disabled = true
			if position.x - $"../../../Player".position.x > 100:
				state = State.BOOM
		State.BOOM:
			if soundB == true:
				$MissileMove.stop()
				$MoveSoundTimer.stop()
				$MissileBoom.play()
				soundB = false
			$AnimatedSprite2D.play("boom")
			if $AnimatedSprite2D.frame == 3:
				queue_free()

func _on_timer_timeout() -> void:
	state = State.FIRE

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		state = State.BOOM
		body.hurt()
		
func _on_near_miss_body_exited(body):
	if body.name == "Player":
		if body.hurted == false:
			if body.state == body.State.NORMAL:
				$"../../..".nearMiss()

func _on_warning_sound_timer_timeout() -> void:
	$WarningSound.stop()
	$WarningSound.play()

func _on_move_sound_timer_timeout() -> void:
	$MissileMove.stop()
	$MissileMove.play()
