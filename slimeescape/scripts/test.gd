extends Node2D

var pelletCount : int = 0
var distance : int = 0
@onready var start : int = $Player.position.x
var score : int
var paused : bool = false

func _ready():
	resize()
# Called every        frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Viewport.NOTIFICATION_WM_SIZE_CHANGED:
		resize()
	$Floor.position.x = $Player.position.x
	$Ceiling.position.x = $Player.position.x
	
	distance = ($Player.position.x - start)/10
	$UI/Distance.text = "Dist: " + str(distance) + "m"

func pelletGet():
	pelletCount += 1
	score += 10
	$UI/Pellets.text = str(pelletCount)

func _on_restart_pressed():
	setHighScore()
	get_tree().reload_current_scene()

func resize():
	$UI/GameOverScreen/Initials.position.x = get_viewport_rect().size.x/2 - $UI/GameOverScreen/Initials.size.x - 8
	$UI/GameOverScreen/LineEdit.position.x = get_viewport_rect().size.x/2 - 2
	$UI/GameOverScreen/Score.position.x = get_viewport_rect().size.x/2 - $UI/GameOverScreen/Score.size.x/2
	$UI/GameOverScreen/GameOver.position.x = get_viewport_rect().size.x/2 - $UI/GameOverScreen/GameOver.size.x/2
	$UI/GameOverScreen/Restart.position.x = get_viewport_rect().size.x/2 - $UI/GameOverScreen/Restart.size.x/2
	$UI/GameOverScreen/Quit.position.x = get_viewport_rect().size.x/2 - $UI/GameOverScreen/Quit.size.x/2
	$UI/Pause.position.x = get_viewport_rect().size.x - 30
	$UI/GameOverScreen/ColorRect.size = get_viewport_rect().size
	$UI/PauseScreen/ColorRect.size = get_viewport_rect().size
	$UI/PauseScreen/Quit.position.x = get_viewport_rect().size.x/2 - $UI/PauseScreen/Quit.size.x/2
	$UI/PauseScreen/Continue.position.x = get_viewport_rect().size.x/2 - $UI/PauseScreen/Continue.size.x/2

func endGame():
	$UI/GameOverScreen.visible = true
	score += distance
	$UI/GameOverScreen/Score.text = "Score: " + str(score)
	$UI/GameOverScreen/Score.position.x = get_viewport_rect().size.x/2 - $UI/GameOverScreen/Score.size.x/2
	if score > HighScores.HighScore10:
		$UI/GameOverScreen/GameOver.text = "New High Score!"
		$NewHighScore.play()
	else:
		$UI/GameOverScreen/LineEdit.visible = false
		$UI/GameOverScreen/Initials.visible = false


func nearMiss():
	score += 50
	$Player/Near.visible = true
	$Player/NearMissTimer.start()

func _on_pause_pressed():
	paused = true
	get_tree().paused = true
	$UI/PauseScreen.visible = true

func _on_quit_pressed():
	if paused == false:
		setHighScore()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_continue_pressed():
	paused = false
	get_tree().paused = false
	$UI/PauseScreen.visible = false
	
func setHighScore():
	if score > HighScores.HighScore10:
		if score > HighScores.HighScore9:
			HighScores.HighScore10 = HighScores.HighScore9
			HighScores.Initials10 = HighScores.Initials9
			if score > HighScores.HighScore8:
				HighScores.HighScore9 = HighScores.HighScore8
				HighScores.Initials9 = HighScores.Initials8
				if score > HighScores.HighScore7:
					HighScores.HighScore8 = HighScores.HighScore7
					HighScores.Initials8 = HighScores.Initials7
					if score > HighScores.HighScore6:
						HighScores.HighScore7 = HighScores.HighScore6
						HighScores.Initials7 = HighScores.Initials6
						if score > HighScores.HighScore5:
							HighScores.HighScore6 = HighScores.HighScore5
							HighScores.Initials6 = HighScores.Initials5
							if score > HighScores.HighScore4:
								HighScores.HighScore5 = HighScores.HighScore4
								HighScores.Initials5 = HighScores.Initials4
								if score > HighScores.HighScore3:
									HighScores.HighScore4 = HighScores.HighScore3
									HighScores.Initials4 = HighScores.Initials3
									if score > HighScores.HighScore2:
										HighScores.HighScore3 = HighScores.HighScore2
										HighScores.Initials3 = HighScores.Initials2
										if score > HighScores.HighScore1:
											HighScores.HighScore2 = HighScores.HighScore1
											HighScores.Initials2 = HighScores.Initials1
											HighScores.HighScore1 = score
											HighScores.Initials1 = $UI/GameOverScreen/LineEdit.text
										else:
											HighScores.HighScore2 = score
											HighScores.Initials2 = $UI/GameOverScreen/LineEdit.text
									else:
										HighScores.HighScore3 = score
										HighScores.Initials3 = $UI/GameOverScreen/LineEdit.text
								else:
									HighScores.HighScore4 = score
									HighScores.Initials4 = $UI/GameOverScreen/LineEdit.text
							else:
								HighScores.HighScore5 = score
								HighScores.Initials5 = $UI/GameOverScreen/LineEdit.text
						else:
							HighScores.HighScore6 = score
							HighScores.Initials6 = $UI/GameOverScreen/LineEdit.text
					else:
						HighScores.HighScore7 = score
						HighScores.Initials7 = $UI/GameOverScreen/LineEdit.text
				else:
					HighScores.HighScore8 = score
					HighScores.Initials8 = $UI/GameOverScreen/LineEdit.text
			else:
				HighScores.HighScore9 = score
				HighScores.Initials9 = $UI/GameOverScreen/LineEdit.text
		else:
			HighScores.HighScore10 = score
			HighScores.Initials10 = $UI/GameOverScreen/LineEdit.text
	else:
		pass
	HighScores.saveScores()
