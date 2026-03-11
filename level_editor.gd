extends Node2D

#set this const before game start
const in_edit_mode: bool = false
var current_level_name = "rude"

var level_info = {
	"rude": {
		"fk_times": "[[1],[2],[3],[4]]",
		"music": load("res://01. RUDE!.mp3")
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$MusicPlayer.stream = level_info.get(current_level_name).get("music")
	$MusicPlayer.play()
	
	if in_edit_mode:
		pass
	else: 
		var fk_times = level_info.get(current_level_name).get("fk_times")
		var fk_times_arr = str_to_var(fk_times)
		print(fk_times_arr[0])
		
		var counter: int = 0
		for key in fk_times_arr:
			
			var button_name: String = ""
			match counter:
				0:
					button_name = "button_D"
				1:
					button_name = "button_F"
				2:
					button_name = "button_J"
				3:
					button_name = "button_K"
			
			for delay in key:
				SpawnFallingKey(button_name, delay)
				
			counter +=1

func SpawnFallingKey(button_name: String, delay: float):
	await get_tree().create_timer(delay).timeout
	Signals.CreateFallingKey.emit(button_name)
