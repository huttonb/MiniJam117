extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var zoomIncrements = [Vector2(.25,.25), Vector2(.5, .5), Vector2(1, 1), Vector2(1.5, 1.5), Vector2(2, 2), Vector2(3, 3)]
var zoomLevel = 1:
	set = set_zoomLevel, get = get_zoomLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func scroll_zoom(zoomDirection):
	if zoomDirection > 0:
		if zoomIncrements[zoomLevel] != zoomIncrements[-1]:
			set_zoomLevel(zoomLevel+1) 
	elif zoomDirection < 0:
		if zoomIncrements[zoomLevel] != zoomIncrements[0]:
			set_zoomLevel(zoomLevel-1)
			
func set_zoomLevel(zoomVar):
	var tween := create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	zoomLevel=zoomVar
	tween.tween_property(self, "zoom", zoomIncrements[zoomLevel], .3)
	#zoom=zoomIncrements[zoomLevel]
func get_zoomLevel():
	return zoomLevel
