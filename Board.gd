extends Node

export var min_outer_margin = 20
export var min_inner_margin = 10
export var tile_dimensions = 32
export var word_size = 6

var current_resolution

func _ready():
	current_resolution = OS.window_size

func _process(delta):
	
	if current_resolution != OS.window_size:
		current_resolution = OS.window_size
		redraw()

	var tile_scale = get_tile_scale(
		current_resolution, 
		tile_dimensions, 
		word_size, 
		min_outer_margin, 
		min_inner_margin)

func get_tile_scale(resolution, tile_dim, tile_num, outmargin, inmargin):
	var num_margins = tile_num - 1
	var result = (resolution.x - (2 * outmargin) - (num_margins * inmargin)) / (tile_num * tile_dim)
	return result

func get_padding(resolution, tile_scale, tile_num, outmargin, inmargin):
	var num_margins = tile_num - 1
	var result = resolution.x - (tile_scale * tile_num) - (2 * outmargin) - (2 * num_margins)
	return result

func get_in_margin(padding, tile_num):
	var num_margins = tile_num - 1
	# Ratio of remaining padding is 2:1 out_margin to in_margin, with preference
	# to in_margin, which is clamped to multiples of num_margins
	var in_margin_pool_total = padding / 3
	return int(in_margin_pool_total / num_margins)

func get_out_margin(padding):
	# Remaining padding goes to out_margins
	return int(padding / 2)

func redraw():
	pass
