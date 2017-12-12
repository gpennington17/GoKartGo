extends Area2D

onready var bullet_position = get_node("position")

const FIRING_TIMER = .25
var firing_countdown = 0.0
var impulse_shoot_speed = 10
var velocity_shoot_speed = 30000

var bullet = preload("res://Scenes/player_bullet.tscn")

var mouse_down = false

var mouse_pos = Vector2()
var mouse_vector
#var sprite_node


func _ready():
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)
	#sprite_node = get_node("Sprite3")


func _fixed_process(delta):
	self.set_rot((mouse_pos - get_global_pos()).angle())
	


func _process(delta):
	firing_countdown += delta
	
	mouse_pos = get_global_mouse_pos()
	mouse_vector = mouse_pos - self.get_global_pos()
	#sprite_node.set_rot(get_angle_to(mouse_pos))
	if mouse_down and firing_countdown >= FIRING_TIMER: 
		print("mouse click")
		_shoot_bullet()
	
	
func _input(event):
	
	if event.is_action_pressed("mouse_down"): mouse_down = true
	if event.is_action_released("mouse_down"): mouse_down = false
	
func _shoot_bullet():
	print("shooting")
	var new_bullet = bullet.instance()
	#var bullet_rotation = get_angle_to(mouse_pos) + self.get_rot()
	var bullet_rotation = get_rot() 
	new_bullet.set_rot(bullet_rotation)
	new_bullet.set_global_pos(bullet_position.get_global_pos())
	get_parent().add_child(new_bullet)
	
	#var rigidbody_vector = (mouse_pos - self.get_pos()).normalized()
	#var mouse_distance = self.get_pos().distance_to(mouse_pos)
	#new_bullet.set_linear_velocity(rigidbody_vector * velocity_shoot_speed * delta)#mouse_distance * delta)
	#new_bullet.apply_impulse(Vector2(), mouse_vector * impulse_shoot_speed)
	new_bullet.start_at(bullet_rotation, get_node("position").get_global_pos())
	firing_countdown = 0