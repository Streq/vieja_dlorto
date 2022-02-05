extends Node
var highscore = 0
const SAVE_PATH := "user://save.res"

func _ready():
	load_game()

func load_game():
	var savegame = File.new()
	var err = savegame.open(SAVE_PATH, File.READ)
	if !err:
		highscore = savegame.get_var().highscore
		savegame.close()
	
func save_game():
	var savegame = File.new()
	var save_data = {"highscore":Global.highscore}
	
	savegame.open(SAVE_PATH, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()
