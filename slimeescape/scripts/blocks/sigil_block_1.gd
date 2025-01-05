extends Node2D

@onready var sigil = preload("res://obstacles/sigil.tscn").instantiate()

var sigilActive : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sigilActive == true:
		sigil.position.y = move_toward(sigil.position.y, 140, .5)
		if sigil.finished == true:
			$"..".spawnBlock(240)
			queue_free()

func _on_start_body_entered(body):
	if body.name == "Player":
		position.x = 0
		sigil.position.y = 30
		add_child(sigil)
		$ChargeTimer.start()


func _on_charge_timer_timeout():
	if sigil.state == sigil.State.CHARGE:
		sigil.state = sigil.State.FIRE
		$FireTimer.start()
	if sigil.state == sigil.State.WAIT:
		sigilActive = true
		sigil.state = sigil.State.CHARGE
		$ChargeTimer.start()

func _on_fire_timer_timeout():
	sigil.state = sigil.State.POWERDOWN
