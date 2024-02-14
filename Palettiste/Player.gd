extends CharacterBody2D

@onready var flip : bool = false

@onready var idle_state : bool = true
@onready var jump_state : bool = true

@onready var jump_buffer : bool = false
@onready var buffer_timer = $BufferTime

@onready var dashing : bool = false
@onready var dash_speed : int = 500000
@onready var dash_timer = $Dash_Timer
@onready var can_dash_timer = $can_dash_timer
@onready var can_dash : bool = true

@export var vitesse : int = 300000

@export var jump_height: float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = (( -2.0 * jump_height)/ (jump_time_to_peak * jump_time_to_peak))* -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var direction = Input.get_axis("Gauche","Droite")



func _physics_process(delta):
	
	if velocity == Vector2.ZERO and idle_state :
		$AnimationPlayer.play("idle")
	var direction = Input.get_axis("Gauche","Droite")
	if direction :
		velocity.x = direction * vitesse * delta
		slow_friction(delta)
		if Input.is_action_pressed("Gauche") :
			course_gauche()
		if Input.is_action_pressed("Droite") :
			course()
	else :
		velocity.x = move_toward (velocity.x,0,vitesse)
	
	if direction and dashing == true:
		velocity.x += direction * dash_speed * delta
	
	if is_on_floor() :
		if Input.is_action_just_pressed("Saut") or jump_buffer == true :
			velocity.y = jump_velocity
			jump_buffer = false
			
	if velocity.y < 0:
		saut()
	if velocity.y > 0:
		saut()

	if Input.is_action_just_pressed("Saut") :
		jump_buffer = true
		buffer_timer.start()

	if not is_on_floor():
		velocity.y += get_gravity() * delta

	if Input.is_action_just_pressed("Dash") and can_dash:
		idle_state = false
		can_dash = false
		dashing = true
		dash_timer.start()
		can_dash_timer.start()
		dash()

	if Input.is_action_just_pressed("Shoot"):
		idle_state = false
		$AnimationPlayer.play("Slash")
		await $AnimationPlayer.animation_finished
		idle_state = true
	
	move_and_slide()

func slow_friction(delta):
	velocity.x -= .02 * delta

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _on_hit_box_area_entered(area):
	if area.name == ("ball_Hitbox"):
		Balle.hit()
		if not is_on_floor():
			HitStop.hit_stop_short()

func _on_buffer_time_timeout():
	jump_buffer = false 

func _on_dash_timer_timeout():
	dashing = false

func _on_can_dash_timer_timeout():
	can_dash = true

func saut() :
	if idle_state == true:
		$AnimationPlayer.play("Saut")

func course():
	if idle_state == true:
		$AnimationPlayer.play("Course")
func course_gauche():
	if idle_state == true:
		$AnimationPlayer.play("Course_gauche")

func idle():
	if idle_state == true:
		$AnimationPlayer.play("idle")
func dash():
		$AnimationPlayer.play("Dash")
		await $AnimationPlayer.animation_finished
		idle_state = true



