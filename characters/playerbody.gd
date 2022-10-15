extends CharacterBody2D

@export var shell: PackedScene

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var aim_direction = Vector2.RIGHT

func _process(delta):
	aim_direction = global_position.direction_to(get_global_mouse_position())

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
	var s = shell.instantiate()
	owner.add_child(s)
	s.transform = %Shotgun/Muzzle.global_transform
	
func _look(delta):
	%Shotgun.look_at(get_global_mouse_position())
	
