extends Node2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$"..".spawnBlock(520)

func _on_near_miss_body_exited(body):
	if body.name == "Player":
		if body.hurted == false:
				if body.state == body.State.NORMAL:
					$"../..".nearMiss()
