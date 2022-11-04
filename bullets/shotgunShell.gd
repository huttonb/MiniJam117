extends Shell

const ShotgunPellet = preload("res://bullets/shotgunPellet.tscn")

func _constructor():
	shell_name = "shotgun"

# Called when the node enters the scene tree for the first time.
func _ready():
	_spread()
	_clean()

func _spread():
	var spread_angles = [0, 22.5, 45, -22.5, -45]
	for angle in spread_angles:
		var radians = (angle * PI) / 180 # convert deg to rad
		var shotgunPellet = ShotgunPellet.instantiate()
		shotgunPellet._constructor()
		shotgunPellet.transform = transform
		shotgunPellet.rotate(radians)
		self.add_child(shotgunPellet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
