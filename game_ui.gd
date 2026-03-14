extends Node
@onready var score_screen = $"ScoreScreen"
@onready var music_player = $"../LevelEditor/MusicPlayer"

var score: int = 0
var combo_count: int = 0
var max_combo: int = 0

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

var perfect_counter: int = 0
var great_counter: int = 0
var good_counter: int = 0
var ok_counter: int = 0
var miss_counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	ResetCombo()
	score_screen.visible = false
	music_player.finished.connect(_on_music_player_finished)
	
func IncrementScore(incr: int):
	if incr > 1:
		score += incr
	%score_label.text = str(score) + " pts"
	if incr ==  perfect_press_score:
		perfect_counter += 1
	elif incr == great_press_score:
		great_counter += 1
	elif incr == good_press_score:
		good_counter += 1
	elif incr == ok_press_score:
		ok_counter +=1
	elif incr == 1:
		miss_counter += 1

func IncrementCombo():
	combo_count += 1
	%combo_label.text = str(combo_count) + "x combo"
	if combo_count > max_combo:
		max_combo = combo_count


func ResetCombo():
	combo_count = 0
	%combo_label.text = ""

func _on_music_player_finished() -> void:
	score_screen.visible = true
	%FinalScore.text = "Final score: " + str(score)
	%MaxCombo.text = "Max combo: " + str(max_combo)
	%Types.text = "Perfect: " + str(perfect_counter) + "\nGreat: " + str(great_counter) + "\nGood: " + str(good_counter) + "\nOk: " + str(ok_counter) + "\nMiss: " + str(miss_counter)

func _on_button_pressed() -> void:
	var player = get_parent().get_parent().get_node("Player")
	player.can_move = true
	get_parent().queue_free()
