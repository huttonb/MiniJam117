extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var new_velocity = direction * SPEED
	velocity = new_velocity
	move_and_slide()
	
	
func _input(event):
	if Input.is_action_pressed("shoot"):
		pass
	
	
