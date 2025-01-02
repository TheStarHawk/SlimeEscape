extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$"../..".pelletGet()
		queue_free()
