extends KinematicBody2D

var health = 10 setget set_health 

var direction = Vector2() 
var speed = 0 
var acceleration = 3000 
var decceleration = 3000 

var motion = Vector2() 
var target_motion = Vector2() 
var steering = Vector2() 

const MASS = 2 
var max_speed = 2000 

var car = null 
var target_angle = 0 

#signal health_changed 

var speedTexture = preload("res://Images/Sprites/speed_car.png") 
var tankTexture = preload("res://Images/Sprites/tank.png") 


func _ready(): 
	car = get_node("player_sprite") 
	set_car(car) 
	add_to_group("player") 
	yield(utils.create_timer(4.0), "timeout") 
	set_fixed_process(true)
	
func _fixed_process(delta):
	 
	direction = Vector2() 
	
	if Input.is_action_pressed("ui_left"):
		direction.x = -1 
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1 
	if Input.is_action_pressed("ui_up"): 
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1 
	#if Input.is_action_pressed("player_shoot"):
	#shoot() 
	
	if direction != Vector2() :
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
		
		# handle collisions 
	
		
		var n = get_collision_normal() 
		move(direction * speed * delta) 
		
	if motion != Vector2():
		target_angle = atan2(motion.x, motion.y) - PI/2 
		car.set_rot(target_angle) 
		
func set_car(car):
	if global.car_type == "fast":
		car.set_texture(speedTexture) 
		max_speed = 3000 
		health = 8 
	elif global.car_type == "armored":
		car.set_texture(tankTexture)
		max_speed = 1000 
#Set the health of the player car 
func set_health(new_value):
	health = new_value
	emit_signal("health_changed", health ) 
	#if health <= 0 : 
	#	print("Game over") 
	#	queue_free()
	 
		
	

func _on_outside_track_body_enter( body ):
	print("outside the track, slow speed") 


func _on_inside_track_body_enter( body ):
	print("inside the track, slow speed") 


func _on_pond_body_enter( body ):
	print("Entered first pond")
	set_health(0) 
	
	
func _on_pond2_body_enter( body ):
	print("Entered second pond") 
	set_health(0) 

func _on_pond3_body_enter( body ):
	print("entered 3rd pond") 
	set_health(0) 