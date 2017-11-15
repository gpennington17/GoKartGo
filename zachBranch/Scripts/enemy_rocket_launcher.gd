#enemy_rocket_launcher 

extends Area2D

export var health = 2 setget set_health 
const rocket_scene = preload("res://Scenes/rocket_enemy.tscn") 

func _ready():
	set_process(true)
	add_to_group("enemy") 
	yield(utils.create_timer(1.0), "timeout") 
	shoot() 
	

func _process(delta):
	#clamp to view
	var pos = get_pos()
	set_pos(pos)
	
	
func set_health(new_value):
	health = new_value
	if health <= 0:
		queue_free()   

func shoot():
	while true:
		var current_position = get_rotd() 
		if current_position == 0.0:
			set_rotd(45.0)  
		elif current_position == 45.0:
			set_rotd(0.1) 
		elif current_position == 0.1:
			set_rotd(-45.0)
		else:
			set_rotd(0.0)  
		
		var pos_left = get_node("launchers/left").get_pos()
		var pos_right = get_node("launchers/right").get_pos() 
		
		create_rocket(pos_left)
		create_rocket(pos_right)
		yield(utils.create_timer(1.0), "timeout") 
		
		
		
func create_rocket(pos):
	var rocket = rocket_scene.instance()
	rocket.set_pos(pos)
	add_child(rocket) 
	#utils.main_node.add_child(rocket) 
	pass
	