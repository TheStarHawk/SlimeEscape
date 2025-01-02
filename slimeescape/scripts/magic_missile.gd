extends CharacterBody2D

enum State {WARNING, FIRE,BOOM}
var state = State.WARNING
var speed = -250

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$Warning.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.WARNING:
			$Warning.visible = true
			position .y = $"../../Player"  .position.y
			position.x = $"../../Player".position.x + 293
		State.FIRE:
			$Warning.visible = false
			move_and_collide(Vector2(speed * delta, 0))
			$CollisionShape2D.disabled = true
			if $"../../Player".position.x - position.x > 100:
				self.queue_free()
		State.BOOM:
			$AnimatedSprite2D.play("boom")
			if $AnimatedSprite2D.frame == 3:
				queue_free()

func _on_timer_timeout() -> void:
	state = State.FIRE

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		state = State.BOOM
		body.hurt()
