extends Node

const ITEM_NAME          = 0
const ITEM_ID            = 1
const ITEM_TYPE          = 2
const ITEM_ICON          = 3
const ITEM_SPRITE        = 4
const ITEM_ANIMATION     = 5  #TABELA
const ITEM_DESCRIPTION   = 6  #TEXTO

const ITEM_ATRIBUTES     = 7  #TABELA
const ITEM_VOLUME        = 8
const ITEM_DURABILITY    = 9
const ITEM_TIMER        = 10  #Tempo de uso (como barra de tempo de uso)

const ITEM_CANNOT_USE   = 11
const ITEM_USED         = 12
const ITEM_CONSUMED     = 13
const ITEM_STACKS       = 14
const ITEM_MOUNT        = 15

var item_database = [
	{
		ITEM_ID   :  0,
		ITEM_NAME  : "Motor",
		ITEM_TYPE   : "equip",
		ITEM_ICON    : 0 ,
		ITEM_SPRITE   : 0,
		ITEM_ANIMATION : "",
		
		ITEM_DESCRIPTION : "Motor para Naves",
		ITEM_ATRIBUTES   :{},
		ITEM_VOLUME      : 10.0,
		ITEM_DURABILITY  : 6.0,
		ITEM_TIMER       : 0.0,
		
		ITEM_CANNOT_USE : false,
		ITEM_USED       : false,
		ITEM_CONSUMED   : false,
		ITEM_STACKS     : true,
		ITEM_MOUNT      : false
	},
	{
		ITEM_ID   :  1,
		ITEM_NAME  : "Bloco Radioativo",
		ITEM_TYPE   : "fuel",
		ITEM_ICON    : 1 ,
		ITEM_SPRITE   : 1,
		ITEM_ANIMATION : "",
		
		ITEM_DESCRIPTION : "Combustivel radioativo",
		ITEM_ATRIBUTES   :{},
		ITEM_VOLUME      : 2.0,
		ITEM_DURABILITY  : 10.0,
		ITEM_TIMER       : 0.0,
		
		ITEM_CANNOT_USE : false,
		ITEM_USED       : false,
		ITEM_CONSUMED   : false,
		ITEM_STACKS     : true,
		ITEM_MOUNT      : false
	},
	{
		ITEM_ID   :  2,
		ITEM_NAME  : "Money",
		ITEM_TYPE   : "cash",
		ITEM_ICON    : 2 ,
		ITEM_SPRITE   : 2,
		ITEM_ANIMATION : "",
		
		ITEM_DESCRIPTION : "Bufunfa",
		ITEM_ATRIBUTES   :{},
		ITEM_VOLUME      : 2.0,
		ITEM_DURABILITY  : 10.0,
		ITEM_TIMER       : 0.0,
		
		ITEM_CANNOT_USE : false,
		ITEM_USED       : false,
		ITEM_CONSUMED   : false,
		ITEM_STACKS     : true,
		ITEM_MOUNT      : false
	},
	{
		ITEM_ID   :  3,
		ITEM_NAME  : "Nave",
		ITEM_TYPE   : "Nave",
		ITEM_ICON    : 3 ,
		ITEM_SPRITE   : 3,
		ITEM_ANIMATION : "",
		
		ITEM_DESCRIPTION : "Nave de combate",
		ITEM_ATRIBUTES   :{},
		ITEM_VOLUME      : 2.0,
		ITEM_DURABILITY  : 10.0,
		ITEM_TIMER       : 0.0,
		
		ITEM_CANNOT_USE : false,
		ITEM_USED       : false,
		ITEM_CONSUMED   : false,
		ITEM_STACKS     : true,
		ITEM_MOUNT      : false
	},
		{
		ITEM_ID   :  4,
		ITEM_NAME  : "Voador",
		ITEM_TYPE   : "Nave",
		ITEM_ICON    : 4 ,
		ITEM_SPRITE   : 4,
		ITEM_ANIMATION : "",
		
		ITEM_DESCRIPTION : "Voador",
		ITEM_ATRIBUTES   :{},
		ITEM_VOLUME      : 2.0,
		ITEM_DURABILITY  : 10.0,
		ITEM_TIMER       : 0.0,
		
		ITEM_CANNOT_USE : false,
		ITEM_USED       : false,
		ITEM_CONSUMED   : false,
		ITEM_STACKS     : true,
		ITEM_MOUNT      : false
	},
]

var item_map = { }

func _ready():
	for i in range(item_database.size()):
		item_map[item_database[i][ITEM_NAME]] = i

func get_item(n):
	return item_map[n]

func get_item_name(i):
	return item_database[i][ITEM_NAME]

func get_id(i):
	return item_database[i][ITEM_ID]
	
func get_item_type(i):
	return item_database[i][ITEM_TYPE]

func get_item_stacks(i):
	return item_database[i][ITEM_STACKS]

func get_item_icon(i):
	return item_database[i][ITEM_ICON]

func get_item_sprite(i):
	return item_database[i][ITEM_SPRITE]

func get_item_animation(i):
	return item_database[i][ITEM_ANIMATION]

func get_item_description(i):
	return item_database[i][ITEM_DESCRIPTION]

func get_item_atributes(i):
	return item_database[i][ITEM_ATRIBUTES]

func get_item_volume(i):
	return item_database[i][ITEM_VOLUME]

func get_item_durability(i):
	return item_database[i][ITEM_DURABILITY]

func get_item_timer(i):
	return item_database[i][ITEM_TIMER]

func get_item_mount(i):
	return item_database[i][ITEM_MOUNT]
	

func can_use_item(i):
	return use_item(i, true) == ITEM_CANNOT_USE

func use_item(i, pretend = false):
	var item = item_database[i]
	if item.has(ITEM_TYPE):
		print("Item usado")
	return ITEM_CANNOT_USE
