extends Node2D

enum State {WAIT, CHARGE, FIRE, POWERDOWN}
var state = State.WAIT
var wait : bool = false
var charge : bool = false
var fire : bool = false
var powerDown : bool = false
var finished : bool = false

func _process(_delta):
	global_position.x = $"../../../Player/Camera2D".global_position.x
	match state:
		State.WAIT:
			if wait == false:
				$AnimatedSprite2D.play("Wait")
				wait = true
			$NearMiss/CollisionShape2D.disabled = true
			$Hurtbox/CollisionShape2D.disabled = true
		State.CHARGE:
			if charge == false:
				$SigilCharge.play()
				charge = true
			$NearMiss/CollisionShape2D.disabled = true
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("Load")
		State.FIRE:
			if fire == false:
				$SigilCharge.stop()
				$SigilFire.play()
				$FireAudio.start()
				fire = true
			$NearMiss/CollisionShape2D.disabled = false
			$Hurtbox/CollisionShape2D.disabled = false
			$AnimatedSprite2D.play("Fire")
		State.POWERDOWN:
			if powerDown == false:
				$FireAudio.stop()
				$SigilFire.stop()
				$SigilPowerDown.play()
				powerDown = true
			$NearMiss/CollisionShape2D.disabled = true
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("powerDown")
			if $AnimatedSprite2D.frame == 5:
				self.visible = false

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_near_miss_body_exited(body):
	if body.name == "Player":
		if body.hurted == false:
				if body.state == body.State.NORMAL:
					$"../../..".nearMiss()


func _on_fire_audio_timeout() -> void:
	$SigilFire.stop()
	$SigilFire.play()


func _on_sigil_power_down_finished() -> void:
	finished = true
