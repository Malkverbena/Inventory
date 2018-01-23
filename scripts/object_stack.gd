extends Control

var item  = null
var count = 0
var pilha 
var menu = null
var moving = false

var container = null
var dragging  = null
var timer    = null

var ItemDatabase 
var Monitor
var sprite
var label
var dummy

const SPRITE_SIZE = 16  # the size of the sprite
const ICON_SIZE = 64
const RAW_LENGTH = 32
const SLOT_SIZE = 64

const MENU_USE      = 0
const MENU_SPLIT    = 1
const MENU_DESTROY  = 2
const MENU_STACK    = 3
var ObjectStack = get_script()

func _init(i, c):
	item = i
	count = c
		
	sprite = Sprite.new()
	add_child(sprite)
	label = Label.new()
	add_child(label)
	set_size(Vector2(ICON_SIZE, ICON_SIZE))

func _ready():
	ItemDatabase = get_node("/root/Item_database")
	Monitor = get_node("/root/monitor")
	set_custom_minimum_size(Vector2(64,64))
	layout()

func layout():
	if count <= 0:
		queue_free()
	var icon = ItemDatabase.get_item_icon(item)
	var tip = ItemDatabase.get_item_description(item)
	set_tooltip(tip)
	sprite.set_position(get_size()/2)
	sprite.set_scale(get_size()/ICON_SIZE)
	sprite.set_texture(preload("res://assets/Icons.png"))
	sprite.set_region(true)
	sprite.set_region_rect(Rect2(ICON_SIZE * (icon % RAW_LENGTH), ICON_SIZE * (icon / RAW_LENGTH), ICON_SIZE, ICON_SIZE))
	if count > 1:
		label.show()
		label.set_align(Label.ALIGN_RIGHT)
		label.add_color_override("font_color", Color(0, 0, 0))
		label.add_color_override("font_color_shadow", Color(50, 50, 50))
		label.set_text(str(count))
		label.set_position(Vector2(get_size().x-40, 0))
		label.set_size(Vector2(40, 10))
	else:
		label.hide()

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		show_menu(get_global_transform().get_origin() + event.position)
		accept_event()


func get_drag_data(p):
	var pilha = ObjectStack.new(item, count)
	var object = [self, pilha, get_parent().get_parent().get_parent().get_parent()]
	var drag_preview = ObjectStack.new(item, count)
	drag_preview.set_size(Vector2(SLOT_SIZE, SLOT_SIZE))
	Monitor.cache_drag = object
	set_drag_preview(drag_preview)

	pilha = null
	queue_free()
	return object

func can_drop_data(p, v):
	Monitor.dragando = true
	if v[1].item == item: #---testa se é do mesmo tipo 
		if v[0] != self:
		#---Testar se o item é empilhável
		#---Testar se existe espaço no invetário
			return true
	else:
		return false

func drop_data(p, v):
	Monitor.dragando = false
	Monitor.cache_drag = null
	count += v[1].count
	layout()

func show_menu(pos):
	if menu != null:
		menu.queue_free()
	menu = PopupMenu.new()
	menu.connect("id_pressed", self, "_menu_item")
	if ItemDatabase.can_use_item(item):  #--Usar Item
		menu.add_item("Use", MENU_USE)

	if count > 1:                        #----Dividir
		menu.add_item("Split", MENU_SPLIT)
	for h in range (get_parent().get_child_count()):
		if h != get_position_in_parent():
			if self.item == get_parent().get_children()[h].item:
				menu.add_item("Stack", MENU_STACK)
				break
	menu.add_item("Destroy", MENU_DESTROY)    #----Descartar
	if menu.get_item_count() > 0:
		add_child(menu)
		menu.set_position(pos)
		menu.popup()
		return
	menu = null

func _menu_item(id):
	print(id)
	var pos = menu.get_position()
	menu.queue_free()
	menu = null
	if id == MENU_USE:
		#var use_result = get_node("/root/item_database").use_item(item)
		#if use_result == ItemDatabase.ITEM_CONSUMED:
		if count == 1:
			queue_free()
		else:
			split(1)
			layout()
	elif id == MENU_SPLIT:
		if count == 2:
			get_parent().add_child(split(1))
		else:
			menu = PopupPanel.new()
			add_child(menu)
			var spinbox = SpinBox.new()
			menu.add_child(spinbox)
			spinbox.set_position(Vector2(1, 1))
			spinbox.set_value(count>>1)
			spinbox.set_min(1)
			spinbox.set_max(count-1)
			spinbox.set_step(1)
			var button = Button.new()
			menu.add_child(button)
			button.set_text("OK")
			button.set_position(Vector2(2+spinbox.get_size().x, 1))
			button.connect("pressed", self, "_split_ok")
			menu.set_position(pos)
			menu.set_size(spinbox.get_size()+Vector2(3+button.get_size().x, 2))
			menu.popup()
	elif id == MENU_DESTROY:
		queue_free()
	elif id == MENU_STACK:
		for i in range(1, get_parent().get_child_count()):
			for j in range(i):
				if get_parent().get_children()[j].item == get_parent().get_children()[i].item && get_parent().get_children()[j].item == self.item:
					get_parent().get_children()[j].count = get_parent().get_children()[j].count + get_parent().get_children()[i].count
					get_parent().get_children()[j].layout()
					get_parent().get_children()[i].queue_free()

func _split_ok():
	var contador = int(menu.get_child(0).get_value())
	get_parent().add_child(split(contador), false)
	menu.queue_free()
	menu = null

func split(n):
	if count <= n:
		return null
	var script = get_script()
	var s = script.new(item, n)
	count -= n
	layout()
	return s