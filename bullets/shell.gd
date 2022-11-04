extends Node2D

class_name Shell

const Bullet = preload("res://bullets/bullets.tscn")
var shell_name: String

func _constructor():
	shell_name = "default"

# Called when the node enters the scene tree for the first time.
func _ready():
	_spread()	
	_clean()


func _spread():
	var bullet = Bullet.instantiate()
	bullet._constructor()
	self.add_child(bullet)

func _clean():
	await get_tree().create_timer(20).timeout
	queue_free()
