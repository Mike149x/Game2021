extends Node


export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

var current_ammo = clip_size
var can_fire = true

func _process(delta):
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		print("Fired weapon")
		can_fire = false
		current_ammo -= 1
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
