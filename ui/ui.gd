extends CanvasLayer
@onready var count : Label = $MarginContainer/VBoxContainer/Label2
func _ready():
	Balle.connect("update_combo", update_stat)

func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()

func update_stat():
	update_combo_ui()


func update_combo_ui():
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer, "scale", Vector2(1, 1), 0.2 ).from(Vector2(1.4,1.4))
	
	count.text = str(Balle.combo)
	

	
