extends Node2D

enum State {WAIT, CHARGE, FIRE, POWERDOWN}
var state = State.CHARGE
var finished : bool = false

func _process(_delta):
	global_position.x = $"../../../Player/Camera2D".global_position.x
	match state:
		State.WAIT:
			$NearMiss/CollisionShape2D.disabled = true
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("Wait")
		State.CHARGE:
			$NearMiss/CollisionShape2D.disabled = true
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("Load")
		State.FIRE:
			$NearMiss/CollisionShape2D.disabled = false
			$Hurtbox/CollisionShape2D.disabled = false
			$AnimatedSprite2D.play("Fire")
		State.POWERDOWN:
			$NearMiss/CollisionShape2D.disabled = true
			$Hurtbox/CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("powerDown")
			if $AnimatedSprite2D.frame == 5:
				self.visible = false
				finished = true

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_near_miss_body_exited(body):
	if body.name == "Player":
		if body.hurted == false:
				if body.state == body.State.NORMAL:
					$"../../..".nearMiss()
