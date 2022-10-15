extends Area2D

const SPEED = 400

# Called when the node enters the scene tree for the first time.
func _ready ():
	_clean()
	
func _clean():
	await get_tree().create_timer(10).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * SPEED * delta

func _on_bullet_body_entered(body):
	if body.is_in_group("enemies"): # TODO
		body.kill_enemy() # TODO
	queue_free()
	
