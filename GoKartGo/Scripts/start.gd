extends Node2D

var arrow = null
var current_selection = null   


func _ready():
	
	arrow = get_node("selection_arrow")
	current_selection = "start"  


	
	
func select():
	
	while true:
		var x_pos = arrow.get_pos().x 
		var y_pos = arrow.get_pos().y 
		
		
		
		
		if Input.is_action_pressed("ui_down"):
			if current_selection == "start":
				current_selection = "options"
				arrow.set_pos(Vector2(x_pos, y_pos + 50)) 
			elif current_selection == "options":
				current_selection = "credits"
				arrow.set_pos(Vector2(x_pos, y_pos + 50)) 
	
		elif Input.is_action_pressed("ui_up"):
			if current_selection == "options":
				current_selection = "start" 
				arrow.set_pos(Vector2(x_pos, y_pos - 50))
			elif current_selection == "credits":
				current_selection = "options"
				arrow.set_pos(Vector2(x_pos, y_pos - 50))
				
		elif Input.is_action_pressed("ui_accept") :
			if current_selection == "start":
				get_tree().change_scene("res://Scenes/GoKartGo.tscn")
				break
			elif current_selection == "options":
				get_tree().change_scene("res://Scenes/options_menu.tscn") 
				break
				
			
			
		yield(utils.create_timer(0.2), "timeout") 
		
			
		
			
		 
	

	
		



func _on_startButton_input_event( ev ):
	queue_free()
	get_tree().change_scene("res://Scenes/GoKartGo.tscn")










func _on_startButton_pressed():
	#queue_free()
	#get_tree().change_scene("res://Scenes/GoKartGo.tscn")
	print("start") 

func _on_optionsButton_pressed():
	print("options")


func _on_creditsButton_pressed():
	print("credits") 
