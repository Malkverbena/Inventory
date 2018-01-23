extends Node

var Monitor 

func _ready():
	Monitor = get_node("/root/monitor")

func can_drop_data(pos, data):
	Monitor.dragando = true
	return true
	
func drop_data(pos, data):
	Monitor.dragando = false
	Monitor.cache_drag = null
	
	#---Aplicar questionamento de destruição de dados aqui.
	
	#--Devolve a pilha pra janela originária
	if data[2] != null:
		data[2].get_node("corpo/ScrollContainer/GridContainer").add_child(data[1])