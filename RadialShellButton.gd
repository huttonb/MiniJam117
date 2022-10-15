extends TextureButton

@export var radius = 120
@export var speed = 0.25

var num
var active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Buttons.hide()
	num = $Buttons.get_child_count()
	for b in $Buttons.get_children():
		b.position = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_radial_shell_button_pressed():
	disabled = true
	if active:
		hide_menu()
	else:
		show_menu()

func _on_tween_completed():
	disabled = false
	active = not active
	if not active:
		$Buttons.hide()

func show_menu():
	var tween = get_tree().create_tween()
	var spacing = TAU / num
	for b in $Buttons.get_children():
		var a = spacing * b.get_index() - PI / 2
		var dest = b.position + Vector2(radius, 0).rotated(a)
		tween.tween_property(b, "position", dest, speed).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT) 
		tween.tween_property(b, "scale", Vector2.ONE, speed).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(self._on_tween_completed)
	$Buttons.show()

	

		
func hide_menu():
	var tween = get_tree().create_tween()
	for b in $Buttons.get_children():
		tween.tween_property(b, "position", self.position, speed).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween.tween_property(b, "scale", Vector2(0.5,0.5), speed).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(self._on_tween_completed)
