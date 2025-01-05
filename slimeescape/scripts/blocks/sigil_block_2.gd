extends Node2D

var fireOrder : int = 0
@onready var sigil1 = preload("res://obstacles/sigil.tscn").instantiate()
@onready var sigil2 = preload("res://obstacles/sigil.tscn").instantiate()
@onready var sigil3 = preload("res://obstacles/sigil.tscn").instantiate()
@onready var sigil4 = preload("res://obstacles/sigil.tscn").instantiate()
@onready var sigil5 = preload("res://obstacles/sigil.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sigil1.position.y = 31
	sigil2.position.y = 139
	sigil3.position.y = 58
	sigil4.position.y = 112
	sigil5.position.y = 85
	sigil1.state = sigil1.State.WAIT
	sigil2.state = sigil2.State.WAIT
	sigil3.state = sigil3.State.WAIT
	sigil4.state = sigil4.State.WAIT
	sigil5.state = sigil5.State.WAIT

func _on_spawner_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		add_child(sigil1)
		add_child(sigil2)
		add_child(sigil3)
		add_child(sigil4)
		add_child(sigil5)
		$Charge.start()


func _on_charge_timeout() -> void:
	match fireOrder:
		0:
			sigil1.state = sigil1.State.CHARGE
			sigil2.state = sigil2.State.CHARGE
		1:
			sigil3.state = sigil3.State.CHARGE
			sigil4.state = sigil4.State.CHARGE
			sigil1.state = sigil1.State.POWERDOWN
			sigil2.state = sigil2.State.POWERDOWN
		2:
			sigil5.state = sigil5.State.CHARGE
			sigil3.state = sigil3.State.POWERDOWN
			sigil4.state = sigil4.State.POWERDOWN
		3:
			sigil5.state = sigil5.State.POWERDOWN
	fireOrder += 1
	$Fire.start()

func _on_fire_timeout() -> void:
	match fireOrder:
		1:
			sigil1.state = sigil1.State.FIRE
			sigil2.state = sigil2.State.FIRE
		2:
			sigil3.state = sigil3.State.FIRE
			sigil4.state = sigil4.State.FIRE
		3:
			sigil5.state = sigil5.State.FIRE
		4:
			$"..".spawnBlock(320)
			queue_free()
	$Charge.start()
