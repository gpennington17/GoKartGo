extends KinematicBody2D
#for health of car variables
export (int) var max_health = 100
export (int) var health = 100

var direction = Vector2()
var speed = 0
var acceleration = 1800
var decceleration = 3000

var motion = Vector2()
var target_motion = Vector2()
var steering = Vector2()
const MASS = 2

const MAX_SPEED = 600


var Skin = null
var target_angle = 0

func _ready():
	Skin = get_node("Sprite")
	set_fixed_process(true)
	get_node("../StaticBody2D").connect("body_enter",self,"_on_StaticBody2D_body_enter")
	get_node("../StaticBody2D").connect("body_exit",self,"_on_StaticBody2D_body_exit")



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
	if is_colliding():
		#print("Collision with ",get_collider())
		var n = get_collision_normal()
		direction = n.slide( direction )
		move(direction*speed*delta)
		get_node("Camera2D").shake(0.1,500,10)
	if motion != Vector2():
		target_angle = atan2(motion.x, motion.y) - PI/2
		Skin.set_rot(target_angle)

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


