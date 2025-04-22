extends CharacterBody2D

var speed : int = 200
const JUMP_VELOCITY : int = -550.0
var gravity : int = 1200
var dash : bool = true
var maximo_dash : int = 2
var dash_stop : bool = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	if dash_stop:
		if $Animaciones.flip_h == false:
			direction = 1
		else:
			direction = -1
			
	if direction:
		$Animaciones.flip_h = direction < 0
		velocity.x = direction * speed
	else:
		##velocity.x = 0
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_just_pressed("Dash"):
		if dash == true:
			dash_stop = true
			speed = 200 + 350
			#$Animaciones.animation = "dash"
			#$Animaciones.play("dash")
			$Dash_on.start(0.3)
			dash = false
	_animaciones()

	#if is_on_floor():
		#if velocity.x != 0:
			#$Animaciones.animation = "Move"
#
	#elif not is_on_floor():
		#if velocity.y <= -1:
			#$Animaciones.animation = "Jump"
			#$Animaciones.play("Jump")
	#if velocity.x == 0 && is_on_floor():
		#$Animaciones.play("Idle")
	move_and_slide()

func _on_dash_on_timeout():
	speed = 200
	$Cooldawn_Dash.start(0.5)
	$Dash_on.stop()
	dash_stop = false
	pass # Replace with function body.

func _on_cooldawn_dash_timeout():
	dash = true
	$Cooldawn_Dash.stop()
	pass # Replace with function body.
	
func  _animaciones():
	if dash_stop :
		$Animaciones.animation = "dash"
		$Animaciones.play("dash")
	elif not is_on_floor():
		$Animaciones.animation = "Jump"
		$Animaciones.play("Jump")
	elif velocity.x != 0:
		$Animaciones.animation = "Move"
		$Animaciones.play("Move")
	else:
		$Animaciones.animation = "Idle"
		$Animaciones.play("Idle")
	
