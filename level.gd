class_name Level

var bg_name: String
var distance: float
var npc_dict: Dictionary
var spawn_seconds: float = 3

func _init(distance, bg, npcs, spawn_seconds):
	self.distance = distance
	self.bg_name  = bg
	self.npc_dict = npcs
	self.spawn_seconds = spawn_seconds
