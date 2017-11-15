#flare

extends Sprite

func _ready():
	get_node("anim").play("fadeout")
	yield(get_node("anim"), "finished")
	queue_free()
	
