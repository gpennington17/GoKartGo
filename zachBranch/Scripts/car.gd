#Car 


extends Area2D

var direction = Vector2()
var speed = 0
var acceleration = 1800
var decceleration = 3000

var motion = Vector2()
var target_motion = Vector2()
var steering = Vector2()

const MASS = 2
const MAX_SPEED = 1500

#var health = Vector2() 
#var health_bar = null 
var health = 4 setget set_health 

var Skin = null
var target_angle = 0

#const rocket_scene = preload("res://Scenes/player_rocket.tscn")

signal health_changed 



func _ready():
	print("Hello") 
	Skin = get_node("player_sprite")
	add_to_group("player")
	set_fixed_process(true)


func _fixed_process(delta):
	
	direction = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1

	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
		
	if Input.is_action_pressed("ui_select"):
		shoot_rocket()
	
	# set the speed of the vehicle 
	if direction != Vector2():
		speed += acceleration * delta
	else:
		speed -= decceleration * delta
	
	speed = clamp(speed, 0, MAX_SPEED)
	
	
	target_motion = speed * direction.normalized() * delta
	steering = target_motion - motion

	if steering.length() > 1:
		steering = steering.normalized()
	motion += steering / MASS

	if speed == 0:
		motion = Vector2()

	move(motion)
	
	#handle car collisions 
	if is_colliding():
		
		var colliding_with = get_collider()
		
		if colliding_with.get_name() == "health_power_up":
			power_up_health(colliding_with)   
			
		elif colliding_with.get_name() == "missile_power_up":
			power_up_missile(colliding_with) 
			
		elif colliding_with.get_name() == "speed_power_up":
			power_up_speed(colliding_with)  
		  
		var n = get_collision_normal()
		direction = n.slide( direction )
		move(direction*speed*delta)
		
	if motion != Vector2():
		target_angle = atan2(motion.x, motion.y) - PI/2
		Skin.set_rot(target_angle)
		
	
#Set the health of the player car 
func set_health(new_value):
	health = new_value 
	if health <= 0 : 
		queue_free()

# grab the speed power up (lightning bolt) 
func power_up_speed(colliding_with):
	print("Colliding with speed")
	colliding_with.queue_free()  

# grab the missile power up 
func power_up_missile(colliding_with):
	print("Colliding with missile")  
	colliding_with.queue_free()  

#grab the health power up 
func power_up_health(colliding_with) : 
	print("Colliding with health") 
	colliding_with.queue_free()
	var health_bar = get_node("player_health/background_sprite/red_bar") 
	var current_health = health_bar.get_scale() 
	 
	if current_health.x != 1 : 
		current_health.x += .10 
		health_bar.set_scale(current_health)    
		
# shoot a rocket 
func shoot_rocket():
	var launcher_location = get_node("launcher_position").get_global_pos()
	create_rocket(launcher_location)
	
# instantiate a rocket 
#func create_rocket(pos):
	#var rocket = rocket_scene.instance() 
	#rocket.set_pos(pos)
	#utils.main_node.add_child(rocket)
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
#func _on_StaticBody2D_body_enter( body ):
#		print("Entered Area2D with body ", body)
	
#func _on_StaticBody2D_body_exit( body ):
#		print("Exited Area2D with body ", body)
	


#func _on_area_2d_body_enter( body ):
#	print("collision is getting detected")
#	var groups = body.get_groups()
#	
#	if(groups.has("bullet")):
#		print("bullet if")
#		health -= body.get_damage()
#		if(health <= 0):
#		 	#die
#			print("health = 0")
#			queue_free()


