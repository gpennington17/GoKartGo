#Car 


extends KinematicBody2D

var direction = Vector2()
var speed = 0
var acceleration = 1800
var decceleration = 3000

var motion = Vector2()
var target_motion = Vector2()
var steering = Vector2()

const MASS = 2
var max_speed = 2000

var health = 10 setget set_health 

var Skin = null
var target_angle = 0

#const rocket = preload("res://Scenes/player_rocket.tscn")
signal health_changed 


var speedTexture = preload("res://Images/Cars/Black_viper.png")
var tankTexture = preload("res://Images/Cars/tank.png") 



func _ready():
	#set_car() 
	Skin = get_node("player_sprite")
	set_car(Skin) 
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
		
	if Input.is_action_pressed("ui_turbo"):
		#check for turbo boosts 
		use_turbo() 
	
	# set the speed of the vehicle 
	if direction != Vector2():
		speed += acceleration * delta
	else:
		speed -= decceleration * delta
	
	speed = clamp(speed, 0, max_speed)
	
	
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
		
		print(colliding_with.get_name())
		
		if colliding_with.get_name() == "health_power_up":
			power_up_health(colliding_with)   
			
		elif colliding_with.get_name() == "missile_power_up":
			power_up_missile(colliding_with) 
			
		elif colliding_with.get_name() == "speed_power_up":
			power_up_speed(colliding_with)  
			
		elif colliding_with.get_name() == "ponds":
			set_health(0)
			
		elif colliding_with.get_name() == "ocean" or colliding_with.get_name() == "ocean1":
			set_health(0)
		  
		var n = get_collision_normal()
		#direction = n.slide( direction )
		
		move(direction*speed*delta)
		
	if motion != Vector2():
		target_angle = atan2(motion.x, motion.y) - PI/2
		Skin.set_rot(target_angle)
		
	
	
	
	
func set_car(Skin):
	if global.car_type == "fast":
		Skin.set_texture(speedTexture)
		max_speed = 3000 
		health = 8 
	elif global.car_type == "armored":
		Skin.set_texture(tankTexture)
		max_speed = 1000
	
		
	
#Set the health of the player car 
func set_health(new_value):
	health = new_value
	emit_signal("health_changed", health ) 
	if health <= 0 : 
		print("Game over") 
		queue_free()

# grab the speed power up (lightning bolt) 
func power_up_speed(colliding_with):
	print("Colliding with speed")
	utils.find_node("turbo_icon").number_turbo += 1 
	colliding_with.queue_free()  

# grab the missile power up 
func power_up_missile(colliding_with):
	print("Colliding with missile")  
	utils.find_node("missile_icon").number_missiles += 3 
	colliding_with.queue_free()  

#grab the health power up 
func power_up_health(colliding_with) : 
	print("Colliding with health") 
	if health >= 9: 
		set_health(10)
	else:
		set_health(health + 2) 
		
	colliding_with.queue_free()


func use_turbo():
	var num_turbo = utils.find_node("turbo_icon").number_turbo
	var begin_turbo = num_turbo 
	var begin_max = max_speed 
	
	if num_turbo > 0 :
		max_speed = begin_max + 1000
		num_turbo = begin_turbo - 1 
		utils.find_node("turbo_icon").set_num_turbo(num_turbo)
		yield(utils.create_timer(3.0), "timeout")
		max_speed = begin_max - 1000
	  
		
		 
		 
  
		
# shoot a rocket 
func shoot_rocket():
	#var launcher_location = get_node("launcher_position").get_global_pos()
	pass 
	
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


