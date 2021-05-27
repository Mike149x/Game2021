extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

onready var ammo_label = $"/root/MainScene/UI/Label"
onready var raycast = $"../Head/Camera/WeaponRayCast"
var current_ammo = 0
var can_fire = true
var reloading = false


func _ready():
	current_ammo = clip_size

func _process(delta):
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
	
	if Input.is_action_pressed("primary_fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire()
				#fires the weapon
		elif not reloading:
			#so if ammo is less than 1 and NOT reloading, the gun will reload
			reload()
	
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()
		
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed" + collider.name)

func fire():
	print("Fired weapon")
	can_fire = false
	current_ammo -= 1
	#after firing, ammo minus 1
	check_collision()
		
	yield(get_tree().create_timer(fire_rate), "timeout")
	#creates timer, waits before fire_rate, then fires
		
	can_fire = true
	

func reload():
	if current_ammo < clip_size :
		print("Reloading...")
		reloading = true
		yield(get_tree().create_timer(reload_rate), "timeout")
		#creates timer, waits before reload_rate, then fires
		current_ammo = clip_size
		reloading = false
		print("Reload Complete")
		





