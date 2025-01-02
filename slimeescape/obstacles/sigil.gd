extends Node2D

enum State {CHARGE, FIRE, POWERDOWN}
var state = State.CHARGE

func _process(delta):
	global_position.x = $"../../Player/Camera2D".global_position.x
	match state:
		State.CHARGE:
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("Load")
		State.FIRE:
			$Hurtbox/CollisionShape2D.disabled = false
			$AnimatedSprite2D.play("Fire")
		State.POWERDOWN:
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("powerDown")
			if $AnimatedSprite2D.frame == 5:
				self.queue_free()
			

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_charge_timer_timeout():
	state = State.FIRE
	$FireTimer.start()
	
func _on_fire_timer_timeout():
	state = State.POWERDOWN
