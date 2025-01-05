extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$RetroWaterDrop01.pitch_scale = randi_range(10, 12)/10
		$RetroWaterDrop01.play()
		body.pelletGet()
		visible = false


func _on_retro_water_drop_01_finished() -> void:
	queue_free()
