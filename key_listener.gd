extends Sprite2D

@onready var falling_key = preload("res://falling_key.tscn")
@onready var score_text = preload("res://score_press_text.tscn")
@export var key_name: String = ""


var falling_key_queue = []

# if distance_from_pass is less than threshold then give that score
var perfect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80
# otherwise miss

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(key_name):
		pass
	# make sure there's a falling key to check for this key
	if falling_key_queue.size() > 0:
		var fk = falling_key_queue.front()
		if not is_instance_valid(fk):
			falling_key_queue.pop_front()
			return
		# if the falling key has passed remove it from queue
		if fk.has_passed:
			falling_key_queue.pop_front()
		# if key is pressed pop from queue and calculate distance from critical point
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			
			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
			elif distance_from_pass < great_press_threshold:
				Signals.IncrementScore.emit(great_press_score)
			elif distance_from_pass < good_press_threshold:
				Signals.IncrementScore.emit(good_press_score)
			elif distance_from_pass < ok_press_threshold:
				Signals.IncrementScore.emit(ok_press_score)
			else:
				# miss
				pass
			
			key_to_pop.queue_free()
			
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.global_position = global_position
			st_inst.global_position.x -= 40;
	
func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.call_deferred("Setup", position.x, frame + 4)
	
	falling_key_queue.push_back(fk_inst)

func _on_random_spawn_timer_timeout() -> void:
	CreateFallingKey()
	$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
	$RandomSpawnTimer.start()
	
