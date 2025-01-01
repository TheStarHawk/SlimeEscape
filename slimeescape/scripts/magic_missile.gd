extends CharacterBody2D

enum State {WARNING, FIRE}
var state = State.WARNING
var speed = -1000

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$Warning.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.WARNING:
			$Warning.visible = true
			position.y = $"../Player"  .position.y
			position.x = $"../Player".position.x + 323
		
		State.FIRE:
			$Warning.visible = false
			velocity.x = speed * delta


func _on_timer_timeout() -> void:
	state = State.FIRE
