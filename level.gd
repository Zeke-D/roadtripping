class_name Level

var bg_name: String
var distance: float
var npc_dict: Dictionary

func _init(distance, bg, npcs):
	self.distance = distance
	self.bg_name  = bg
	self.npc_dict = npcs
