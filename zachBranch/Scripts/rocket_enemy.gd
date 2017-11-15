# rocket_enemy 

extends "res://Scripts/rocket.gd"


func _ready():
	connect("body_enter", self, "_on_body_enter")
	pass

func _on_body_enter(body):
	if body.is_in_group("player"):
		print("Collision with player")
		body.health -= 1  
		print(body.health) 
		#create_fireball() 
		queue_free() 
		

	

