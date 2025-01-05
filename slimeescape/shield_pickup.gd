extends Area2D

var direction : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Player":
		body.shieldGet()
		queue_free()
