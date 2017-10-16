extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screensize 
var extents 
var pos
var vel = Vector2(200,150) 

func _ready():
	screensize = get_viewport_rect().size
	extents = get_texture().get_size() / 2 
	pos = screensize / 2 
	
	
	
	set_process(true)
	
func _process(delta):
	set_rot(get_rot() + PI * delta)
	pos += vel * delta 
	
	if pos.x >= screensize.width - extents.width:
		pos.x = screensize.width - extents.width 
		vel.x *= -1 
		
	if pos.x <= extents.width:
		pos.x = extents.width 
		vel.x *= -1
		
	if pos.y >= screensize.height - extents.height:
		pos.y = screensize.height - extents.height 
		vel.y *= -1 
		
	if pos.y <= extents.height: 
		pos.y = extents.height 
		vel.y *= -1 
	
	set_pos(pos)
	
