extends Node2D

#var game_over = preload("res://scenes/game_over.tscn")
var best_score = 0 setget set_bestscore
const file_path = "user://bestscore.data"

onready var player = get_node("Player") 
onready var enemy_ship_one = get_node("enemy_ship_one") 
onready var starting_scene = get_node("start") 


func _ready():
	enemy_ship_one.target = get_node("Player") 
	load_bestscore()
	set_process(true) 
	
func _process(delta):
	if player.health == 0:
		queue_free()
		get_tree().change_scene("res://scenes/game_over.tscn")
	# if enemy_container.get_child_count == 0 you win 
	pass
	
func load_bestscore():
	var file = File.new()
	if not file.file_exists(file_path):
		return
	file.open(file_path, File.READ)
	best_score = File.get_var()
	file.close()
	pass
	
func save_bestscore():
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_var(best_score)
	file.close()
	pass 
	
func set_bestscore(new_value):
	best_score = new_value
	save_bestscore()
	pass
	