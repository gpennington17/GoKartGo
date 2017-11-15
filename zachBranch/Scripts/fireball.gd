#fireball

extends Sprite

func _ready():
	get_node("anim").play("fireball")
	yield(get_node("anim"), "finished")
	queue_free()
	