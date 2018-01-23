extends GridContainer


var Monitor
var ItemDatabase 
const ObjectStack  = preload("res://scripts/object_stack.gd")

func _ready():
	set_physics_process(true)
	Monitor = get_node("/root/monitor")
	ItemDatabase = get_node("/root/Item_database")

func _input_event(event):
	if Input.is_mouse_button_pressed(1):
		get_parent().get_parent().get_node("LineEdit").release_focus()
		get_parent().get_parent().get_parent().move_to_front()

func can_drop_data(pos, variant):
	Monitor.dragando = true

	#---Testar se o inventário não está cheio
	return true

func drop_data(p, v):
	Monitor.dragando = false
	Monitor.cache_drag = null
	add_child(v[1])

# Add items (by name, count)
func add_items(n, c):
	add_child(ObjectStack.new(n, c))
	return 


# Remove items (by name, count)
func remove_items(n, c):
	pass
#	testar se o item existe no inventario
#	procurar quantas pilhas daquele item existem
#	somar todas as pilhas para testar se a quantidade a ser removida está disponível
#				Se a quantidade não estiver disponível, fazer o que?
#	subtrair de cada pilha individualmete a quantidade a ser subtraida
#	if (count_items(n) < c):
#		return false
#	var itemdesc = ItemDatabase.get_item(n)
#	for slot in slots:
#		if slot.stack != null && slot.stack.item == itemdesc:
#			if slot.stack.count > c:
#				slot.remove(c)
#				return
#			else:
#				c -= slot.stack.count
#				slot.remove()



func _on_Stack_all_pressed():
	for i in range(1, get_child_count()):
		for j in range(i):
			if get_children()[j].item == get_children()[i].item:
				get_children()[j].count = get_children()[j].count + get_children()[i].count
				get_children()[j].layout()
				get_children()[i].queue_free()

