extends Node2D

var pelletCount : int = 0
var distance : int = 0
@onready var start : int = $Player.position.x
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Obstacles/MissileTimer.wait_time = randi_range(10, 30)
	$UI/GameOverScreen/ColorRect.size = DisplayServer.screen_get_size()

# Called every        frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Floor.position.x = $Player.position.x
	$Ceiling.position.x = $Player.position.x
	
	distance = ($Player.position.x - start)/10
	$UI/Distance.text = "Dist: " + str(distance) + "m"
	
func missileSpawn():
	var missile = preload("res://obstacles/magic_missile.tscn").instantiate()
	$Obstacles.add_child(missile)

func _on_missile_timer_timeout():
	missileSpawn()
	$Obstacles/MissileTimer.wait_time = randi_range(10, 30)

func pelletGet():
	pelletCount += 1
	$UI/Pellets.text = str(pelletCount)


func _on_restart_pressed():
	get_tree().reload_current_scene()
