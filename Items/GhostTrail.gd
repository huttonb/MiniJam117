extends Sprite2D

var ghost = %Ghost
# Called when the node enters the scene tree for the first time.
func _ready():
	var oldTransform = global_transform
	get_parent().remove_child(self)
	get_tree().get_root().add_child(self)
	transform = oldTransform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_velocity = Vector2.ZERO
	var distance = global_position.distance_to(ghost.global_position)
	if distance > 100:
		new_velocity = global_position.direction_to(ghost.global_position) * (distance)
	#velocity = new_velocity
