extends KinematicBody2D

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
	
	#move
	move(_movement)
