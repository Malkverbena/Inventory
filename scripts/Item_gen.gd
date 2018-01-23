extends TextureRect

export(int)    var itemid = 0


const ObjectStack  = preload("res://scripts/object_stack.gd")

func _ready():
	# Initialization here
	pass

func get_drag_data(p):
	var stack = ObjectStack.new(itemid, 1)
	var object = [self, stack, null]
	remove_child(stack)
	var drag_preview = ObjectStack.new(stack.item, stack.count)
	drag_preview.set_size(Vector2(40, 40))
	set_drag_preview(drag_preview)
	return object
