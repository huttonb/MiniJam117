extends Shell

const SniperBullet = preload("res://bullets/sniperBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_spread()
	_clean()
	
func _spread():
	var sniperBullet = SniperBullet.instantiate()
	sniperBullet._constructor()
	self.add_child(sniperBullet)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
