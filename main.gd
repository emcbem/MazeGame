extends Node2D

const CELL_SIZE = 64
const WALL_THICKNESS = 2

func _ready():
	var maze = MazeGenerator.generate_maze()
	draw_maze(maze)

func draw_maze(maze):
	for y in range(maze.size()):
		for x in range(maze[y].size()):
			var cell = maze[y][x]
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

func draw_wall(x, y, w, h, r):
	var WallScript = load("res://TileSets/Wall.tscn")
	var wall: Wall = WallScript.instantiate()
	wall.global_position = Vector2(x + w / 2, y + h / 2) # Set the position based on the calculated offsets
	wall.scale = Vector2(CELL_SIZE/WALL_THICKNESS, CELL_SIZE/16)
	wall.rotate(r)
	add_child(wall)  # Add the wall to the scene
