extends Node2D

const CELL_SIZE = 32
const WALL_THICKNESS = 4

func _ready():
	var maze = MazeGenerator.generate_maze()
	draw_maze(maze)

func draw_maze(maze: Maze):
	for y in range(maze.grid.size()):
		for x in range(maze.grid[y].size()):
			var cell = maze.grid[y][x]
			var px = x * CELL_SIZE
			var py = y * CELL_SIZE

			# Check and draw each wall of the cell
			if cell["walls"]["N"]:
				draw_wall(px, py, CELL_SIZE, WALL_THICKNESS, -1.5708)  # Top wall
			if cell["walls"]["E"]:
				draw_wall(px + CELL_SIZE - WALL_THICKNESS, py, WALL_THICKNESS, CELL_SIZE, 0)  # Right wall
			if cell["walls"]["S"]:
				draw_wall(px, py + CELL_SIZE - WALL_THICKNESS, CELL_SIZE, WALL_THICKNESS, 1.5708)  # Bottom wall
			if cell["walls"]["W"]:
				draw_wall(px, py, WALL_THICKNESS, CELL_SIZE, 3.14159)  # Left wall
			draw_tile(px, py, cell)

func draw_tile(x, y, cell):
	if(cell['tile'] == null):
		var tile: ColorRect = ColorRect.new()
		tile.set_color(Color8(7, 14, 34))
		tile.global_position = Vector2(x, y)
		tile.size = Vector2(CELL_SIZE, CELL_SIZE)
		add_child(tile)
	else:
		draw_finish(x, y)
	
	
func draw_finish(x, y):
	var Finish = load("res://Components/FinishLine.tscn")
	var finish = Finish.instantiate()
	finish.global_position = Vector2(x + CELL_SIZE / 2, y + CELL_SIZE / 2)
	finish.scale = Vector2(CELL_SIZE/16, CELL_SIZE/16)
	call_deferred("add_child", finish)




func draw_wall(x, y, w, h, r):
	var WallScript = load("res://TileSets/Wall.tscn")
	var wall: Wall = WallScript.instantiate()
	wall.global_position = Vector2(x + w / 2, y + h / 2) # Set the position based on the calculated offsets
	wall.scale = Vector2(CELL_SIZE/WALL_THICKNESS, CELL_SIZE + WALL_THICKNESS)
	wall.rotate(r)
	add_child(wall)  # Add the wall to the scene
