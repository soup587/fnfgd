extends Node2D

var arrows = preload("res://objects/arrow.tscn")
var hud
var noteline

var latestLeft
var latestDown
var latestUp
var latestRight

var difficulty = "normal"

func spawnArrow(direction = 0):
	if direction > 3: return
	direction = str(direction)
	var arrow = arrows.instantiate()
	var target
	match direction:
		"0": target = %HUD/Targets/LeftTarget
		"1": target = %HUD/Targets/DownTarget
		"2": target = %HUD/Targets/UpTarget
		"3": target = %HUD/Targets/RightTarget
	arrow.position.x = target.global_position.x + 64
	arrow.position.y = 900
	arrow.dir = direction
	$HUD/NoteLines.add_child(arrow)
	return arrow
	
func loadFile(location):
	var file = FileAccess.open(location, FileAccess.READ)
	if FileAccess.get_open_error():
		return null
	
	return file.get_as_text()

func parseChart(chartJSON):
	var json = JSON.new()
	return JSON.parse_string(chartJSON)
	

# Called when the node enters the scene tree for the first time.
var chart
var currentNoteNum = 0
var currentNote
func _ready():
	chart = parseChart(loadFile("res://assets/music/tutorial/tutorial-chart.json"))["notes"][difficulty]
	currentNote = chart[0]
	
	hud = $HUD

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if %Song.get_playback_position()*1000 > chart[currentNoteNum]["t"] + 160:
		currentNoteNum += 1
		currentNote = chart[currentNoteNum]
		spawnArrow(currentNote["d"])

	
func _input(event):
	if event.is_action_pressed("Left"):
		if currentNote["d"] == 0:
			if %Song.get_playback_position()*1000 > currentNote["t"] - 160:
				print("hit")
	if event.is_action_pressed("Down"):
		if currentNote["d"] == 1:
			if %Song.get_playback_position()*1000 > currentNote["t"] - 160:
				print("hit")
	if event.is_action_pressed("Up"):
		if currentNote["d"] == 2:
			if %Song.get_playback_position()*1000 > currentNote["t"] - 160:
				print("hit")
	if event.is_action_pressed("Right"):
		if currentNote["d"] == 3:
			if %Song.get_playback_position()*1000 > currentNote["t"] - 160:
				print("hit")
	if event.is_action_pressed("Space"):
		print(%Song.get_playback_position()*1000)
