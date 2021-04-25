extends Node2D

var vel_x = -100
var offset = 500
var start_position_x = null

func _ready():
	start_position_x = position.x

func _process(delta):
	move_local_x(vel_x * delta)	
	
func _physics_process(delta):

	if vel_x < 0 and position.x < start_position_x - offset:
		vel_x *= -1

	if vel_x > 0 and position.x > start_position_x + offset:
		vel_x *= -1
