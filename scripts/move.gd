extends Panel


var moving = false
var ItemDatabase
var monitor

const NAME = 0
const CONTADOR = 1

export var capacidade = 30.0
export var invent_ID = ""

#---Tipos aceitáveis no container
export var canhao = true
export var lancador = true
export var minerais = true

var input
var grade

func _ready():
	set_process_input(true)

	ItemDatabase = get_node("/root/Item_database")
	monitor = get_node("/root/monitor")
	input = $corpo/LineEdit
	grade = $corpo/ScrollContainer/GridContainer
	if invent_ID != "":
		$Label.set_text(invent_ID)  #--Costomizar para cada nescessidade

func _input(ev):
	if ev is InputEventKey:
		if (ev.pressed && (ev.scancode == KEY_KP_ENTER || ev.scancode == KEY_ENTER)):
			mostrador_de_itens()
			if input.has_focus():
				for i in range(grade.get_child_count()):
					var proc = ItemDatabase.get_item_name(grade.get_children()[i].item)
					if proc.findn(input.get_text(), 0) == -1:
						grade.get_children()[i].hide()
					if proc.findn(input.get_text(), 0) != -1:
						grade.get_children()[i].show()
					if input.get_text() == "":
						grade.get_children()[i].show()
		if (ev.pressed && (ev.scancode == KEY_ESCAPE)):
			if input.has_focus():
				input.release_focus()

	if !input.has_focus():
		input.set_text("")
		for i in range(grade.get_child_count()):
			grade.get_children()[i].show()

func  _gui_input(event):

	if !monitor.dragando:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT && event.is_pressed():
			if Input.is_mouse_button_pressed(1):
				input.release_focus()
				move_to_front()

		if event is InputEventMouseMotion:
			if Input.is_mouse_button_pressed(1):
				set_position(get_position() + event.relative)

func _on_corpo_resized():
	set_size(Vector2($corpo.get_size().x, get_size().y))
	set_position(Vector2(get_position().x + $corpo.trans_var_pos, get_position().y))

func move_to_front():
	get_parent().move_child(self, get_parent().get_child_count()-1)



#====-------Utilidades
	
func contador_de_itens():
	return grade.get_child_count()
	
func mostrador_de_itens():
	
	var invent = []
	for i in range(grade.get_child_count()):
		var f = [ ItemDatabase.get_item_name(grade.get_children()[i].item), grade.get_children()[i].count ]
		invent.push_back(f)

#	for j in range(0, invent.size()):
#		for k in range(0, j):
#			if invent[j][0] == invent[k][0]:
#				invent[j][1] = invent[j][1] + invent[k][1]
#				print(invent[k][0])
#				invent.remove(k)

	return invent

func _on_Panel_resized():
	pass # replace with function body
