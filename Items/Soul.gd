extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	if player:
		var playerLocation = player.position
		velocity = position.direction_to(playerLocation) * SPEED
		move_and_slide()
	

func _on_detection_range_body_entered(body):
	player = body


func _on_detection_range_area_entered(area):
	player = area
	pass # Replace with function body.
