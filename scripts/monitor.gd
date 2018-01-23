extends Node

var dragando = false
var cache_drag = null

var focando = false


func _ready():
	set_physics_process(true)

func _physics_process(delta):

	if !Input.is_mouse_button_pressed(1) and cache_drag != null:
		cache_drag[2].get_node("corpo/ScrollContainer/GridContainer").add_child(cache_drag[1])