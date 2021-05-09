extends KinematicBody

var speed = 7
var acceleration = 20
var gravity = 9.8
var jump = 5

var mouse_sensitivity = 0.05

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#hides mouse from screen, can now turn indefinitely in any direction 

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		#separates x and y axis rotation
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
		

func _process(delta):
	#this function updates every frame
	
	direction = Vector3()
	#This resets speed to zero when nothing pressed
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		#when clicking ESC, mouse appears so user can exit
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	
	elif Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
			
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	
	direction = direction.normalized()
	move_and_slide(direction * speed, Vector3.UP)
	










