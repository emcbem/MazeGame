extends TileMapLayer

const WALL_TILE_ID = 0
const CELL_SIZE = 1  # Keep as 1 to match tile coordinates

func _ready():
	var maze = MazeGenerator.generate_maze()
	draw_maze(maze)

func draw_maze(maze):
	
	if(maze != null):
		for y in maze.size():
			for x in maze[y].size():
				var cell = maze[y][x]
				if cell["walls"]["N"]:
					set_cell(Vector2i(x, y - 1), WALL_TILE_ID, Vector2(1, 0))
				if cell["walls"]["E"]:
					set_cell(Vector2i(x + 1, y), WALL_TILE_ID, Vector2(2, 1))
				if cell["walls"]["S"]:
					set_cell(Vector2i(x, y + 1), WALL_TILE_ID, Vector2(1, 2))
				if cell["walls"]["W"]:
					set_cell(Vector2i(x - 1, y), WALL_TILE_ID, Vector2(0, 1))
