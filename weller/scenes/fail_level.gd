extends Node2D

var need_free = false

func _ready():
	$Timer.set_wait_time(2)
	$Timer.start()

func _physics_process(delta):
	if need_free:
		G.start_level()
		free()

func _on_Timer_timeout():
	need_free = true
