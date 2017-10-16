extends KinematicBody2D

export (bool) var explode_on_impact = true

export (int) var damage = 25

#gravity
var _gravity = 0

# Movement
var _movement = Vector2()

func shoot(directional_force, gravity):
	_movement = directional_force
	_gravity = gravity
	set_fixed_process(true)

func _fixed_process(delta):
	#Simulate gravity
	_movement.y <= delta * _gravity
	
	#check if we have collided
	if(is_colliding()):
		if(explode_on_impact):
			explode()
			set_fixed_process(false)
			return
		
		#Get node that we are colliding with
		var entity = get_collider()
		
		#apply physics
		var normal = get_collision_normal()
	#move
	move(_movement)
	
	#if(get_pos().x > OS.get_screen_size().x):
		#queue_free()
	#if(get_pos().y > OS.get_screen_size().y):
		#queue_free()
		#on screen exit
#func _on_visibility_notifier_exit_screen():
	#queue_free()

#on impact
func explode():
	queue_free()


#returns the damage this bullet will deal
func get_damage():
	return damage