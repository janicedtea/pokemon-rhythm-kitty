extends Sprite2D

@onready var falling_key = preload("res://falling_key.tscn")
@export var key_name: String = ""

var falling_key_queue = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(key_name):
		CreateFallingKey()
	
func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, frame + 4)
	
	falling_key_queue.push_back(fk_inst)
