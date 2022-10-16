extends Node2D

class_name Shell

@export var bullet: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var spread_angles = [0, 22.5, 45, -22.5, -45]
	for angle in spread_angles:
		var radians = (angle * PI) / 180 # convert deg to rad
		var b = bullet.instantiate()
		b.transform = transform
		b.rotate(radians)
		self.add_child(b)
	
	_clean()


func _clean():
	await get_tree().create_timer(20).timeout
	queue_free()
