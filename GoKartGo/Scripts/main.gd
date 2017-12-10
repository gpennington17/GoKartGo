extends Node2D

# var game_over = preload("res://scenes/game_over.tscn")

onready var player = get_node("Player") 
onready var enemy_ship_one = get_node("enemy_ship_one") 


func _ready():
	enemy_ship_one.target = player 
	set_process(true) 
	
func _process(delta):
	if player.health == 0:
		queue_free()
		get_tree().change_scene("res://scenes/game_over.tscn")
	# if enemy_container.get_child_count == 0 you win 
	
