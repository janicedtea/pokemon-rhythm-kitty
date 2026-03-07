extends Node

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.IncrementScore.connect(IncrementScore)
	
func IncrementScore(incr: int):
	score += incr
	%score_label.text = str(score) + " pts"
