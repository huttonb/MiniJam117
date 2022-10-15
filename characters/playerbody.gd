extends CharacterBody2D

@export var bullet: PackedScene

const SPEED = 600.0
const JUMP_VELOCITY = -400.0

var flipped = false: set = _flip_character

@onready var stateMachine = %AnimationTree.get("parameters/playback")

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var new_velocity = direction * SPEED
	velocity = new_velocity
	move_and_slide()
	if velocity.length() > 1:
		stateMachine.travel("Walk")
		print("walk")
	elif velocity.length() < -1:
		stateMachine.travel("R_Walk")
		print("rwalk")
	elif(stateMachine.get_current_node() == "Walk" || stateMachine.get_current_node() == "R_Walk"):
		stateMachine.travel("Idle")
		print("idle")
	_look(delta)
	
	
func _input(event):
	if Input.is_action_pressed("shoot"):
		_shoot_shotgun()

func _shoot_shotgun():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = %Shotgun/Muzzle.global_transform
	%Shotgun/GunSprite/ShotgunShotSound.play()
	
	
func _look(delta):
	var lookPos = (get_local_mouse_position().x > 0)
	if (lookPos && !flipped) || (!lookPos && flipped) :
		_flip_character(false)
	else:
		_flip_character(true)
	%LeftArmSprite.look_at(get_global_mouse_position())
	#%RightArmSprite.look_at(self.position)
	%RightArmSprite.global_position = %Shotgun/GunSprite/Pump.global_position
	%RightArmSprite.look_at(%RightShoulder.global_position) 
	%RightArmSprite.rotate(PI)
	%HeadSprite.look_at(get_global_mouse_position())

	
func _flip_character(flip):
	var x_axis = global_transform.x
	global_transform.x.x = (-1 if flip else 1) * abs(x_axis.x)
	flipped = flip

