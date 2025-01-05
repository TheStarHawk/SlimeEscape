extends Node2D

func _on_spawner_body_entered(body):
	if body.name == "Player":
		var missile = preload("res://obstacles/magic_missile.tscn").instantiate()
		$Timer.start()
		missile.tracking = true
		add_child(missile)
		$"..".spawnBlock(525)

func _on_timer_timeout():
	var missile2 = preload("res://obstacles/magic_missile.tscn").instantiate()
	missile2.tracking = true
	add_child(missile2)
