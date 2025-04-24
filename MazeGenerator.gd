extends Node

var grid = []
var width = 21  # Must be odd
var height = 21  # Must be odd

func _ready():
	for y in range(height):
		grid.append([])
		for x in range(width):
			grid[y].append({
				"visited": false,
				"walls": {"N": true, "S": true, "E": true, "W": true}
			})
func generate_maze():
	var stack = []
	var current = Vector2(1, 1)  # Starting point
	grid[current.y][current.x]["visited"] = true

	while true:
		var neighbors = get_unvisited_neighbors(current)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			remove_wall(current, next)
			stack.append(current)
			current = next
			grid[current.y][current.x]["visited"] = true
		elif stack.size() > 0:
			current = stack.pop_back()
		else:
			break
	return grid

func get_unvisited_neighbors(pos):
	var neighbors = []
	var directions = {"N": Vector2(0, -1), "S": Vector2(0,1), "E": Vector2(1, 0), "W": Vector2(-1, 0)}
	for dir in directions:
		var new_pos = pos + directions[dir]
		if new_pos.x >= 0 and new_pos.x < width and new_pos.y >= 0 and new_pos.y < height:
			if not grid[new_pos.y][new_pos.x]["visited"]:
				neighbors.append(new_pos)
	return neighbors

func remove_wall(current, next):
	var dx = next.x - current.x
	var dy = next.y - current.y
	if dx == 1:
		grid[current.y][current.x]["walls"]["E"] = false
		grid[next.y][next.x]["walls"]["W"] = false
	elif dx == -1:
		grid[current.y][current.x]["walls"]["W"] = false
		grid[next.y][next.x]["walls"]["E"] = false
	elif dy == 1:
		grid[current.y][current.x]["walls"]["S"] = false
		grid[next.y][next.x]["walls"]["N"] = false
	elif dy == -1:
		grid[current.y][current.x]["walls"]["N"] = false
		grid[next.y][next.x]["walls"]["S"] = false
