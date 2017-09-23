extends KinematicBody2D

# Bullet Angle
export (float) var bullet_angle = 270 setget set_bullet_angle

# Bullet Speed
export (int) var bullet_speed = 8

# Bullet Gravity
export (int) var bullet_gravity = 0

export (float) var bullet_delay = 0.2
var waited = 0

# Bullet Scene
export (PackedScene) var bullet_scene

# Bullet Spawn\
export(NodePath) var bullet_spawn_path
onready var bullet_spawn = get_node(bullet_spawn_path)

#Directional Force for our bullet
var directional_force = Vector2()

#shooting
var shooting = false

func set_bullet_angle(value):
	bullet_angle = clamp(value, 0, 359)

#update directional force on the bullet being shot
func update_directional_force():
	directional_force = Vector2(cos(bullet_angle*(PI/180)), sin(bullet_angle*(PI/180))) * bullet_speed

func _ready():
	# Update directional force
	update_directional_force()
	
	set_process_input(true)
	
	set_process(true)

func _input(event):
	if(event.is_action_pressed("ui_select")):
		shooting = true
	elif(event.is_action_released("ui_select")):
		shooting = false



func _process(delta):
	if(shooting && waited > bullet_delay):
		fire_once()
		waited = 0
	elif(waited <= bullet_delay):
		waited += delta

func fire_once():
	shoot()
	shooting = false


func shoot():
	var bullet = bullet_scene.instance()
	bullet.set_global_pos(bullet_spawn.get_global_pos())
	bullet.shoot(directional_force, bullet_gravity)
	get_parent().add_child(bullet)
