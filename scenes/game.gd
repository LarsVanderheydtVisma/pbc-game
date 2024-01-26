extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var WIDTH = 240
var HEIGHT = 240

@onready var spaceship = $"../spaceship"

# Called when the node enters the scene tree for the first time.
func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate_chunk(spaceship.position)

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(WIDTH):
		for y in range(HEIGHT):
			var moist = moisture.get_noise_2d(tile_pos.x - WIDTH/2 + x, tile_pos.y - HEIGHT/2 + y) * 10
			var temp = temperature.get_noise_2d(tile_pos.x - WIDTH/2 + x, tile_pos.y - HEIGHT/2 + y) * 10
			var alt = altitude.get_noise_2d(tile_pos.x - WIDTH/2 + x, tile_pos.y - HEIGHT/2 + y) * 10
			
			set_cell(0, Vector2i(tile_pos.x-WIDTH/2 + x, tile_pos.y-HEIGHT/2 + y), 0, Vector2(round((moist+10)/5), round((temp+10)/5)))
