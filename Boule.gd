extends RigidBody2D

signal reset_combo_text
signal update_combo
var combo_state : bool = true
var pos : Vector2 = Vector2.ZERO

var damp : float = -0.01 :
	get :
		return damp
	set (value):
		damp = value

var veloce : Vector2 = Vector2(2500,-2200) :
	get :
		return veloce
	set(value):
		veloce = value

var combo = 0 :
	get :
		return combo
	set(value):
		combo = value
		update_combo.emit()

var rebond = 0 :
	get :
		return rebond
	set(value) :
		rebond = value

func hit():
	reset_rebond()
	linear_velocity = veloce
	linear_damp = damp
	veloce += Vector2(200,-50)
	combo += 1
	damp -= 0.01
	print(damp)
	$AudioStreamPlayer2D.play()

func reset_rebond():
	rebond = 0

