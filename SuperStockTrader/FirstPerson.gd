extends KinematicBody

#THIS SCRIPT HOLDS ALL OF THE VARIABLES RELATING TO MOVEMENT

var speed = 10
var acceleration = 20
var gravity = 9.8
var jump = 6.5

var mouse_sensitivity = 0.30

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#hides mouse from screen, can now turn indefinitely in any direction 

#AIMING WITH MOUSE MOTION
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		#separates x and y axis rotation
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
		#Lets the Player Look around/aim properly

func _process(delta):
	#this function updates every frame
	
	direction = Vector3()
	#This resets speed to zero when nothing pressed
	
	if not is_on_floor():
		fall.y -= gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		fall.y = jump
	#Jumping code, can hold space to 'bunny hop', and can't jump if not on ground
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#when clicking ESC, mouse appears so user can exit
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	#Those four allow movement - forwards, backwards, strafing, and moving diagonally
	#Sometimes if too many directions are pressed at the same time nothing happens
	
	direction = direction.normalized()
	#Makes it so that moving diagonally isn't faster than walking straight
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	#The player slows to a stop, instead of instantly stopping
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
	










