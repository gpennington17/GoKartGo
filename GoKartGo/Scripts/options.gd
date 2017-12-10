#options.gd 

extends Node2D 

var arrow = null
var current_selection = null  
var start = null  


func _ready():
	arrow = get_node("selection_arrow")
	current_selection = "normal" 
	yield(utils.create_timer(0.2), "timeout") 
	start = preload( "res://Scenes/start.tscn" ).instance()
	select() 
	
	
func select():
	
	while true:
		var x_pos = arrow.get_pos().x 
		var y_pos = arrow.get_pos().y 
		
		
		
		
		if Input.is_action_pressed("ui_right"):
			if current_selection == "normal":
				current_selection = "fast"
				arrow.set_pos(Vector2(x_pos + 300, y_pos)) 
			elif current_selection == "fast":
				current_selection = "armored"
				arrow.set_pos(Vector2(x_pos + 300, y_pos)) 
	
		elif Input.is_action_pressed("ui_left"):
			if current_selection == "fast":
				current_selection = "normal" 
				arrow.set_pos(Vector2(x_pos - 300, y_pos))
			elif current_selection == "armored":
				current_selection = "fast"
				arrow.set_pos(Vector2(x_pos - 300, y_pos))
				
		elif Input.is_action_pressed("ui_accept") :
			yield(utils.create_timer(0.2), "timeout") 
			global.car_type = current_selection
			print(global.car_type)
			get_tree().change_scene("res://Scenes/start.tscn") 
			break
			
			
			
			
		yield(utils.create_timer(0.2), "timeout") 

