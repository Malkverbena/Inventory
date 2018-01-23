extends Panel


  #--------Redimencionar Janela
var newSize 
var dragging = [false, false, false]
var trans_var_pos = 0.0
var Monitor 
onready var grid = get_node("ScrollContainer/GridContainer")
onready var scrool = get_node("ScrollContainer")
 
func _ready():
	
	Monitor = get_node("/root/monitor")
	newSize = self.get_size()
	grid.set_custom_minimum_size(get_size()-Vector2(18,8))
	grid.set_size(get_size())
	grid.set_columns(get_size().x/(72))

func _gui_input(event):
	if !Monitor.dragando:
		if Input.is_mouse_button_pressed(1):
			if get_local_mouse_position().x in range (get_size().x-6, get_size().x+6) && get_local_mouse_position().y in range (0, get_size().y):
				dragging[0] = true
			if get_local_mouse_position().x in range (-6, 6) && get_local_mouse_position().y in range (0, get_size().y):
				dragging[1] = true
			if get_local_mouse_position().y in range (get_size().y-6, get_size().y+6) && get_local_mouse_position().x in range (0, get_size().x):
				dragging[2] = true

	if event is InputEventMouseMotion:
		if dragging[0]:
			newSize.x += event.relative.x
			if get_size().x < 100 and event.relative.x < 0:  #---Limita o tamanho mínico da caixa
				newSize.x -= event.relative.x

		if dragging[1]:
			newSize.x += -event.relative.x
			trans_var_pos = event.relative.x
			if get_size().x < 100 and event.relative.x > 0:  #---Limita o tamanho mínico da caixa
				newSize.x += event.relative.x
				trans_var_pos = 0.0
		else:
			trans_var_pos = 0.0

		if dragging[2]:
			newSize.y += event.relative.y
			if get_size().y < 100 and event.relative.y < 0:  #---Limita o tamanho mínico da caixa
				newSize.y -= event.relative.y

	set_size(newSize)

	scrool.set_size(get_size()-Vector2(40,38))
	grid.set_custom_minimum_size(get_size()-Vector2(22,38))
	grid.set_size(get_size()-Vector2(40,38))
	grid.set_columns(get_size().x/(76))

	if !Input.is_mouse_button_pressed(1):
		dragging = [false, false, false]

func _on_fechar_pressed():
	if visible:
		visible = false
	else:
		visible = true
