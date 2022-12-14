extends Area2D

class_name Bullet

var travel_speed: int
@onready var timer = get_tree().create_timer(10).timeout

func _constructor():
	travel_speed = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	_clean()

# TODO: Check if memory has already been freed before calling queue_free	
func _clean():
	await timer
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * travel_speed * delta

func _on_bullet_body_entered(body):
	if body.is_in_group("enemies"): # TODO
		body.kill_enemy() # TODO
	timer.emit()
