extends Node2D

var lastBlock : int = 0
var nextBlock : int
# Called when the node enters the scene tree for the first time.
func _ready():
	$ShieldTimer.wait_time = randi_range(20, 40)
	spawnBlock(200)

func spawnBlock(distance):
	var block
	nextBlock = randi_range(1, 6)
	if nextBlock != lastBlock:
		lastBlock = nextBlock
		match nextBlock:
			1:
				block = preload("res://obstacles/ObstacleBlocks/dagger_block_1.tscn").instantiate()
			2:
				block = preload("res://obstacles/ObstacleBlocks/missile_block_1.tscn").instantiate()
			3:
				block = preload("res://obstacles/ObstacleBlocks/sigil_block_1.tscn").instantiate()
			4:
				block = preload("res://obstacles/ObstacleBlocks/missile_block_2.tscn").instantiate()
			5:
				block = preload("res://obstacles/ObstacleBlocks/sigil_block_2.tscn").instantiate()
			6:
				block = preload("res://obstacles/ObstacleBlocks/dagger_block_2.tscn").instantiate()
		block.position.x = $"../Player".position.x + distance
		add_child(block)
	else:
		spawnBlock(distance)

func _on_shield_timer_timeout():
	
	$ShieldTimer.wait_time = randi_range(20, 40)
	var shield = preload("res://obstacles/shield_pickup.tscn").instantiate()
	$ShieldTimer.wait_time = randi_range(10, 30)
	shield.position.x = $"../Player".position.x + 320
	shield.position.y = 84
	add_child(shield)
