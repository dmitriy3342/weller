extends Node2D

var need_free = false

func _ready():
	$Control/Label.text = 'LEVEL '+str(G.level+1)
	$Timer.set_wait_time(1.5)
	$Timer.start()


func _physics_process(delta):
	if need_free:
		get_tree().paused = false
		free()

func _on_Timer_timeout():
	need_free = true
