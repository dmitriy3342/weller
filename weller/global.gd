extends Node2D

var level = 0
var game:Node2D = null

var audio:AudioStreamPlayer2D = null
var audio_delay = 0
var levels = [
	{
		'resistance':1,
		'acceleration':0.1,
	},
	{
		'resistance':1.5,
		'acceleration':0.12,
	},
	{
		'resistance':2,
		'acceleration':0.12,
	},
	{
		'resistance':3,
		'acceleration':0.12,
	}
]

const helix_touch_ground_y = 120
const helix_touch_water_y = 690
var velocity = 0
var helix:AnimatedSprite = null
var resistance = 1
var acceleration = 0.1

const helix_top_start_y = -484
var helix_top:Sprite = null

const hole_start_y = 593 
const hole_max_size_y = 570
var hole:Sprite = null

const pointer_start_x = 40
const pointer_center_x = 540
const pointer_size_x = 1000
const pointer_end_x = pointer_start_x+pointer_size_x
var pointer:Sprite = null

var pointer_min_percent = 0.1
var pointer_max_percent = 0.9

func start_level():
	helix.position.y = 0
	hole.position.y = hole_start_y
	helix_top.position.y = helix_top_start_y
	hole.scale.y = 0
	pointer.position.x = pointer_start_x
	
	velocity = 0
	resistance = levels[level].resistance
	acceleration = levels[level].acceleration
	
	get_tree().paused = true
	G.sub('start_level')
	


func custom_process(delta):
	if helix.position.y > helix_touch_water_y:
		level+=1
		if level <= len(levels):
			start_level()
		else:
			sub('win_level')
		return
	
	helix.translate(Vector2.DOWN * velocity)
	helix_top.translate(Vector2.DOWN * velocity)
	
	helix.speed_scale = velocity
	
	pointer.position.x = pointer_start_x + pointer_size_x * velocity
	
	
	if velocity>0:
		audio_delay+=delta
		if not audio.playing and audio_delay>=(1-velocity)*0.2: 
			audio.play()
			audio_delay = 0
		
		
		
	var hole_size_y = helix.position.y-helix_touch_ground_y
	if hole_size_y > 0 and hole_size_y < hole_max_size_y:
		
		hole.scale.y = hole_size_y
		hole.position.y = hole_start_y + hole_size_y/2
		
		
		if pointer.position.x < pointer_end_x*pointer_min_percent or \
		   pointer.position.x > pointer_end_x*pointer_max_percent:
			
			get_tree().paused = true
			G.sub('fail_level')
			
	
	velocity-=resistance*delta
	if velocity<0:
		velocity = 0

func _input(event:InputEvent):
	if not (event is InputEventScreenTouch or event is InputEventMouseButton):
		return
	
	if event.pressed:
		velocity+=acceleration
		
		if velocity > 1:
			velocity = 1

func sub(scene_name):
	var scene = load('res://scenes/'+scene_name+'.tscn').instance()
	game.add_child(scene)
	
