extends Node2D


func _ready():
	G.game = $"."
	G.helix = $HelixGroup/Helix
	G.hole = $HelixGroup/Hole
	G.helix_top = $HelixGroup/HelixTop
	G.pointer = $Pointer
	G.audio = $Audio
	G.start_level()


func _process(delta):
	G.custom_process(delta)
	pass	
