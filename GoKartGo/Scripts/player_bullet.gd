extends Area2D

var vel = Vector2() 
var speed = 10000 

func _ready():
	set_fixed_process(true) 
	
func start_at(dir, pos):
	set_rot(dir) 
	set_pos(pos) 
	vel = Vector2(speed, 0).rotated(dir - PI/2) 
	
func _fixed_process(delta):
	set_pos(get_pos() + vel * delta)
	
func _on_player_bullet_area_enter( area ):
	if area.get_groups().has("flying_enemy"):
		print("Entered flying enemy")
	if area.get_groups().has("turret"):
		print("Entered turret")
		#queue_free()
		#area.damage(global.bullet_damage)

func _on_visible_exit_screen():
	queue_free()


func _on_lifetime_timeout():
	queue_free()
