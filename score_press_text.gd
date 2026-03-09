extends Control

#perfect color 96f2f8
#great color 96f29c
#good color 96c5ff
#ok color 9698ff
#miss color 767676


func SetTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"perfect":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("96f2f8"))
		"great":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("96f29c"))
		"good":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("96c5ff"))
		"ok":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("9698ff"))
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("767676"))
