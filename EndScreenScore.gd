extends RichTextLabel

func _init():
	self.text = "YOU GO TO LEVEL: " + str(global.level + 1)
