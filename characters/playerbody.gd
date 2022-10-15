extends CharacterBody2D

@export var bullet: PackedScene

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var new_velocity = direction * SPEED
	velocity = new_velocity
	move_and_slide()
	_look(delta)
	
	
func _input(event):
	if Input.is_action_pressed("shoot"):
		_shoot_shotgun()

func _shoot_shotgun():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = %Shotgun/Muzzle.global_transform
	
func _look(delta):
	%LeftArmSprite.look_at(get_global_mouse_position())
	#%RightArmSprite.look_at(self.position)
	%RightArmSprite.global_position = %Shotgun/GunSprite/Pump.global_position
	%RightArmSprite.look_at(%RightShoulder.global_position) 
	%RightArmSprite.rotate(PI)
	#%Shotgun.look_at(get_global_mouse_position())
	
