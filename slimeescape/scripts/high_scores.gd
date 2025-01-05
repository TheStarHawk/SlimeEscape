extends Node

var HighScore1 : int = 10000
var HighScore2 : int = 9000
var HighScore3 : int = 8000
var HighScore4 : int = 7000
var HighScore5 : int = 6000
var HighScore6 : int = 5000
var HighScore7 : int = 4000
var HighScore8 : int = 3000
var HighScore9 : int = 2000
var HighScore10 : int = 1000

var Initials1 : String = "KPK"
var Initials2 : String = "Bob"
var Initials3 : String = "LOL"
var Initials4 : String = "OwO"
var Initials5 : String = "Kek"
var Initials6 : String = "FAT"
var Initials7 : String = "Git"
var Initials8 : String = "God"
var Initials9 : String = "Dam"
var Initials10 : String = "Wot"

# Called when the node enters the scene tree for the first time.
func _ready():
	loadScores()
	
func scoreDict():
	var save_dict = {
		"HighScore1" = HighScore1,
		"HighScore2" = HighScore2,
		"HighScore3" = HighScore3,
		"HighScore4" = HighScore4,
		"HighScore5" = HighScore5,
		"HighScore6" = HighScore6,
		"HighScore7" = HighScore7,
		"HighScore8" = HighScore8,
		"HighScore9" = HighScore9,
		"HighScore10" = HighScore10,
		"Initials1" = Initials1,
		"Initials2" = Initials2,
		"Initials3" = Initials3,
		"Initials4" = Initials4,
		"Initials5" = Initials5,
		"Initials6" = Initials6,
		"Initials7" = Initials7,
		"Initials8" = Initials8,
		"Initials9" = Initials9,
		"Initials10" = Initials10
	}
	return save_dict
	
func saveScores():
	var saveFile = FileAccess.open("user://HighScores.save", FileAccess.WRITE)
	saveFile.store_line(JSON.stringify(scoreDict()))

func loadScores():
	if not FileAccess.file_exists("user://HighScores.save"):
		var saveFile = FileAccess.open("user://HighScores.save", FileAccess.WRITE)
		saveFile.store_line(JSON.stringify(scoreDict()))
		
	var save_file = FileAccess.open("user://HighScores.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
			# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var stats = json.data
		
		#Load Stats
		HighScore1 = stats["HighScore1"]
		HighScore2 = stats["HighScore2"]
		HighScore3 = stats["HighScore3"]
		HighScore4 = stats["HighScore4"]
		HighScore5 = stats["HighScore5"]
		HighScore6 = stats["HighScore6"]
		HighScore7 = stats["HighScore7"]
		HighScore8 = stats["HighScore8"]
		HighScore9 = stats["HighScore9"]
		HighScore10 = stats["HighScore10"]
		Initials1 = stats["Initials1"]
		Initials2 = stats["Initials2"]
		Initials3 = stats["Initials3"]
		Initials4 = stats["Initials4"]
		Initials5 = stats["Initials5"]
		Initials6 = stats["Initials6"]
		Initials7 = stats["Initials7"]
		Initials8 = stats["Initials8"]
		Initials9 = stats["Initials9"]
		Initials10 = stats["Initials10"]
