extends CanvasLayer


func _ready():
	#get_node("AnimationPlayer").connect("finished",self,"on_finished")
	
	get_node("AnimationPlayer").play("come_down")
	pass
