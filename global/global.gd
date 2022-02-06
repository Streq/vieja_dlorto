extends Node
var highscore = 0
const SAVE_PATH := "user://save.res"

var difficulty = {
	"easy":{"spawn_time":5.0},
	"medium":{"spawn_time":2.5},
	"hard":{"spawn_time":1.0}
}

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

func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("ui_cancel"):
		OS.window_fullscreen = false
		
		
		
