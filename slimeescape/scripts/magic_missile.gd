extends CharacterBody2D

enum State {WARNING, FIRE,BOOM}
var state = State.WARNING
var speed = -250

var tracking : bool = false

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
			$AnimatedSprite2D.visible = true
			$Warning.visible = false
			move_and_collide(Vector2(speed * delta, 0))
			$CollisionShape2D.disabled = true
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
		
func _on_near_miss_body_exited(body):
	if body.name == "Player":
		if body.hurted == false:
			if body.state == body.State.NORMAL:
				$"../../..".nearMiss()
