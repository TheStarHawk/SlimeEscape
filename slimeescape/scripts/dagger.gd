extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += 20 * delta

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		body.hurt()
