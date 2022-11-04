extends CharacterBody2D

@export var shell: PackedScene

const SPEED = 600.0
const JUMP_VELOCITY = -400.0

var reloadTime = .3
var shotGunReady = true
var flipped = false: set = _flip_character

# Holds all available shells
var shells = {}

# The current position in the clip
var shell_order_position = 0

@onready var stateMachine = %AnimationTree.get("parameters/playback")
@onready var oldArmTransform = %LeftArmSprite.transform.origin
@onready var oldShotgunTransform = %Shotgun.transform.origin

func _ready():
	# Initialize the shells
	_initialize_shells()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var new_velocity = direction * SPEED
	velocity = new_velocity
	move_and_slide()
	if velocity.length() > 1:
		if velocity.x >= 0:
			stateMachine.travel("Walk")
		elif velocity.x < 0:
			stateMachine.travel("R_Walk")
	elif(stateMachine.get_current_node() == "Walk" || stateMachine.get_current_node() == "R_Walk"):
		stateMachine.travel("Idle")
	_look(delta)
	
func _input(event):
	const clip = ["shotgun", "sniper", "default"]
	if Input.is_action_pressed("shoot"):
		_shoot_shotgun(clip)


func _initialize_shells():
	var default = Shell.instantiate()
	var sniper = SniperShell.instantiate()
	var shotgun = ShotgunShell.instantiate()
	
	default._constructor()
	sniper._constructor()
	shotgun._constructor()
	
	shells[default.shell_name] = default
	shells[shotgun.shell_name] = shotgun
	shells[sniper.shell_name] = sniper

func _shoot_shotgun(clip: Array):
  if shotGunReady:
		shotGunReady = false
    # Use the ordered shell_order array to get the shell type
    var shell_type = clip[shell_order_position]
    # Use the shell type to get the initialized shell scene
    var shell = shells[shell_type]
    # Add the shell scene
    owner.add_child(shell)

    shell.transform = %Shotgun/Muzzle.global_transform
		%LeftArmSprite.transform.origin = oldArmTransform
		%Shotgun.transform.origin = oldShotgunTransform
		%Shotgun/GunSprite.frame = 0
		var tween := create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween.set_parallel(true) 
		tween.tween_property(%LeftArmSprite, "transform:origin", %LeftArmSprite.transform.origin + %LeftArmSprite.transform.x - Vector2(15,0), reloadTime / 2)
		tween.tween_property(%Shotgun, "transform:origin", %Shotgun.transform.origin + %Shotgun.transform.x - Vector2(25,0), reloadTime / 2)
		tween.chain().tween_property(%LeftArmSprite, "transform:origin", %LeftArmSprite.transform.origin + %LeftArmSprite.transform.x + Vector2(15,0), reloadTime)
		tween.tween_property(%Shotgun, "transform:origin", %Shotgun.transform.origin + %Shotgun.transform.x + Vector2(25,0), reloadTime / 2)
		tween.tween_callback(reload).set_delay(reloadTime / 2)
		_play_shotgun_sounds()

    # Iterate the shell_order_position iterator or restart the from the beginning
    if shell_order_position < (len(clip) - 1):
      shell_order_position += 1
    else:
      shell_order_position = 0
      _initialize_shells()
    
func reload():
	shotGunReady = true

func _play_shotgun_sounds():
	%Shotgun/GunSprite/ShotgunShotSound.play()
	%Shotgun/GunSprite/ShotgunShotSound.connect(
		"finished", 
		func(): %Shotgun/GunSprite/ShotgunPumpSound.play()
	)

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

