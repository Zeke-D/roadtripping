extends RichTextLabel

func _init():
	self.text = "SCORE: " + str(int(global.distance / 1000))
