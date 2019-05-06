extends KinematicBody2D

class_name Player

var _v: Vector2 = Vector2(0, 0)
var _cur_anim: String = ""

onready var anim = $anim

const SPEED = 24



class Movement:
	const UP = "move_up"
	const DOWN = "move_down"
	const LEFT = "move_left"
	const RIGHT = "move_right"


func _ready() -> void:
	_cur_anim = Movement.DOWN


func _physics_process(delta: float) -> void:
	_v = Vector2(0, 0)
	var new_anim: String = _cur_anim

	if Input.is_action_pressed(Movement.UP):
		new_anim = Movement.UP
		_v.y -= 1
	elif Input.is_action_pressed(Movement.DOWN):
		new_anim = Movement.DOWN
		_v.y += 1
	elif Input.is_action_pressed(Movement.LEFT):
		new_anim = Movement.LEFT
		_v.x -= 1
	elif Input.is_action_pressed(Movement.RIGHT):
		new_anim = Movement.RIGHT
		_v.x += 1

	_v = _v.normalized()

	move_and_slide(_v * SPEED)


	if _v.length() == 0:
		anim.stop()
		anim.seek(0, true)

	if new_anim != _cur_anim or !anim.is_playing():
		anim.play(new_anim)
		_cur_anim = new_anim
