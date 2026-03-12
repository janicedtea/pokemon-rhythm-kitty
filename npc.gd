extends CharacterBody2D
const GameLevelScene = preload("res://game_level.tscn")

var player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interaction()
		
func interact():
	var level = preload("res://game_level.tscn").instantiate()
	get_tree().current_scene.add_child(level)

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
