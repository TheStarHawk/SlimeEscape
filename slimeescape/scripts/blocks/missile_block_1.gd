extends Node2D

var missileCount : int = 0

func _on_timer_timeout():
	match missileCount:
		0:
			var missile = preload("res://obstacles/magic_missile.tscn").instantiate()
			missile.position.y = 31
			add_child(missile)
		1:
			var missile1 = preload("res://obstacles/magic_missile.tscn").instantiate()
			missile1.position.y = 58
			add_child(missile1)
		2:
			var missile2 = preload("res://obstacles/magic_missile.tscn").instantiate()
			missile2.position.y = 85
			add_child(missile2)
		3:
			var missile3 = preload("res://obstacles/magic_missile.tscn").instantiate()
			missile3.position.y = 112
			add_child(missile3)
		4:
			var missile4 = preload("res://obstacles/magic_missile.tscn").instantiate()
			missile4.position.y = 139
			add_child(missile4)
			$Timer.wait_time = 12
		5:
			$"..".spawnBlock(520)
		6:
			queue_free()
	missileCount += 1

func _on_start_body_entered(body):
	if body.name == "Player":
		$Timer.start()
