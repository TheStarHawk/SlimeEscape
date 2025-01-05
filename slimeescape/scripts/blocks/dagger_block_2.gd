extends Node2D

func _process(delta: float) -> void:
	if $"../../Player".position.x > position.x + 360 + get_viewport_rect().size.x/4:
		queue_free()

func _on_near_miss_body_exited(body):
	if body.name == "Player":
		if body.hurted == false:
				if body.state == body.State.NORMAL:
					$"../..".nearMiss()


func _on_spawner_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"..".spawnBlock(360)
