#rocket

extends Area2D

export var velocity = Vector2() 
const flare_scene = preload("res://Scenes/flare.tscn") 
const fireball_scene = preload("res://Scenes/fireball.tscn") 

func _ready():
	set_process(true) 
	create_flare()
	yield(get_node("vis_notifier"), "exit_screen") 
	queue_free()
	

func _process(delta):
	translate(velocity * delta)
	 
	

func create_flare():
	var flare = flare_scene.instance() 
	flare.set_pos(get_pos())
	utils.main_node.add_child(flare)
	pass 
	
func create_fireball():
	var fireball = fireball_scene.instance() 
	fireball.set_pos(get_pos())
	add_child(fireball)
	pass 
	