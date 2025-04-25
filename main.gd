extends Node2D

const CELL_SIZE = 64
const WALL_THICKNESS = 2

func _ready():
	var maze = MazeGenerator.generate_maze()
	draw_maze(maze)

func draw_maze(maze: Maze):
	draw_background(maze.grid)
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
	draw_finish(maze.end_pos)
	print(maze.end_pos)
	
func draw_finish(end_pos: Vector2):
	print(end_pos)
	var Finish = load("res://Components/FinishLine.tscn")
	var finish = Finish.instantiate()
	finish.position = end_pos * CELL_SIZE - Vector2(WALL_THICKNESS * 2, WALL_THICKNESS * 2)
	finish.scale = Vector2(CELL_SIZE/32, CELL_SIZE/32)
	add_child(finish)

func draw_background(grid):
	var Background: ColorRect = ColorRect.new()
	Background.set_color(Color8(7, 14, 34))
	print(Background.get_property_list())
	Background.size = Vector2((CELL_SIZE) * (grid.size() ), (CELL_SIZE ) * (grid[0].size() ))
	print(Background.size)
	add_child((Background))

func draw_wall(x, y, w, h, r):
	var WallScript = load("res://TileSets/Wall.tscn")
	var wall: Wall = WallScript.instantiate()
	wall.global_position = Vector2(x + w / 2, y + h / 2) # Set the position based on the calculated offsets
	wall.scale = Vector2(CELL_SIZE/WALL_THICKNESS, CELL_SIZE/16)
	wall.rotate(r)
	add_child(wall)  # Add the wall to the scene
