extends CharacterBody2D

var speed : int = 150
const JUMP_VELOCITY : int = -400.0
var gravity : int = 1200
var dash : bool = true
var maximo_dash : int = 2
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		if direction == 1:
			$Animaciones.flip_h = false
		elif direction == -1:
			$Animaciones.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_just_pressed("Dash"):
		if dash == true:
			speed = 250 + 500
			$Dash_on.start(0.2)
			dash = false

	if is_on_floor():
		if velocity.x != 0:
			$Animaciones.animation = "Move"
##			$Animaciones.flip_h = velocity.x < 0 
	elif not is_on_floor():
		if velocity.y <= -1:
			$Animaciones.animation = "Jump"
			$Animaciones.play("Jump")
		else:
			$Animaciones.animation = "Fall"
			$Animaciones.play("Fall")
	if velocity.x == 0 && velocity.y == 0:
		$Animaciones.play("Idle")
		
	move_and_slide()

func _on_dash_on_timeout():
	speed = 250
	$Cooldawn_Dash.start(2)
	$Dash_on.stop()
	pass # Replace with function body.


func _on_cooldawn_dash_timeout():
	dash = true
	$Cooldawn_Dash.stop()
	pass # Replace with function body.
