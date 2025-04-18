extends CharacterBody2D


var SPEED : int = 150
const JUMP_VELOCITY : int = -400.0
var gravity : int = 1200
var dash : bool = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("Dash"):
		if dash == true:
			SPEED = 250 + 500
			$Dash_on.start(0.2)
	move_and_slide()


func _on_dash_on_timeout():
	SPEED = 250
	dash = false
	$Cooldawn_Dash.start(0.7)
	$Dash_on.stop()
	pass # Replace with function body.


func _on_cooldawn_dash_timeout():
	dash = true
	$Cooldawn_Dash.stop()
	pass # Replace with function body.
