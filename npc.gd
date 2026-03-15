extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
var player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interaction()
		
func interact():
	var dialogue = preload("res://dialogue_layer.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue)
	dialogue.start_dialogue(["uhhh my name's peppermint, who're you?", "um... okay... rude", "whatever"], "Peppermint", preload("res://npc1.png"))
	await dialogue.tree_exited
	
	var level = preload("res://game_level.tscn").instantiate()
	level.get_node("LevelEditor").current_level_name = "rude"
	get_tree().current_scene.add_child(level)
	player.can_move = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		player_in_range = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		player_in_range = false

func interaction():
	print("yayy")
