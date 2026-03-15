extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()
	modulate.a = 0.0
	create_tween().tween_property(self, "modulate:a", 1.0, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
