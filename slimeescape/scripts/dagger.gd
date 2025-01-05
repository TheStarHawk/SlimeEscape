extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += 20 * delta

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_timer_timeout() -> void:
	$Dagger.stop()
	$Dagger.play()


func _on_sound_triger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Timer.start()


func _on_sound_triger_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Timer.stop()
