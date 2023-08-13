extends Node

var distance = 0
var police_chase = false
var level = 0
var BOOST_MULT_DEFAULT = 1.5
var boost_multiplier = 1.5
var BREAK_MULT_DEFAULT = 0.7
var break_multiplier = 0.7
var player_health = 3

const goal_distances = [1, 1, 1, 200000]
const backgrounds = ["Grass", "Desert"]
const level_background = ["Grass", "Grass", "Desert", "Desert"]
