extends Node

var health
var health_max
var lives
var lives_max


func _ready():
	health = 100
	health_max = 100
	lives = 3
	lives_max = 5


func change_health(amount):
	health += amount
	health = clamp(health, 0, health_max)

func change_lives(amount):
	lives += amount
	lives = clamp(lives, 0, lives_max)

func get_health():
	return health

func get_lives():
	return lives






















