extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Scoreboard/ItemList.set_item_text(0, "#1 " + str(HighScores.HighScore1) + " - " + HighScores.Initials1)
	$Scoreboard/ItemList.set_item_text(1, "#2 " + str(HighScores.HighScore2) + " - " + HighScores.Initials2)
	$Scoreboard/ItemList.set_item_text(2, "#3 " + str(HighScores.HighScore3) + " - " + HighScores.Initials3)
	$Scoreboard/ItemList.set_item_text(3, "#4 " + str(HighScores.HighScore4) + " - " + HighScores.Initials4)
	$Scoreboard/ItemList.set_item_text(4, "#5 " + str(HighScores.HighScore5) + " - " + HighScores.Initials5)
	$Scoreboard/ItemList.set_item_text(5, "#6 " + str(HighScores.HighScore6) + " - " + HighScores.Initials6)
	$Scoreboard/ItemList.set_item_text(6, "#7 " + str(HighScores.HighScore7) + " - " + HighScores.Initials7)
	$Scoreboard/ItemList.set_item_text(7, "#8 " + str(HighScores.HighScore8) + " - " + HighScores.Initials8)
	$Scoreboard/ItemList.set_item_text(8, "#9 " + str(HighScores.HighScore9) + " - " + HighScores.Initials9)
	$Scoreboard/ItemList.set_item_text(9, "#10 " + str(HighScores.HighScore10) + " - " + HighScores.Initials10)
	resize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Viewport.NOTIFICATION_WM_SIZE_CHANGED:
		resize()
		
func resize():
	$Scoreboard/ItemList.size.x = get_viewport_rect().size.x/3
	$Menu/Logo.position.x = get_viewport_rect().size.x/2 + $Scoreboard/ItemList.size.x/2
	$Menu/Quit.position.x = get_viewport_rect().size.x/2 - $Menu/Quit.size.x/2 + $Scoreboard/ItemList.size.x/2
	$Menu/Play.position.x = get_viewport_rect().size.x/2 - $Menu/Play.size.x/2 + $Scoreboard/ItemList.size.x/2
	$Menu/ColorRect.size = get_viewport_rect().size


func _on_play_pressed():
	get_tree().change_scene_to_file("res://CollisionShapes/test.tscn")


func _on_quit_pressed():
	get_tree().quit()
