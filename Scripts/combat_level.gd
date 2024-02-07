extends Node2D

var gridInfo = {"character": null,
				"targeted": true,
				"effect": null}

@export var characters: Array[Character]

#  0   1
#╔═══╦═══╗
#║   ║   ║0
#╠═══╬═══╣
#║   ║   ║1
#╠═══╬═══╣
#║   ║   ║2
#╠═══╬═══╣
#║   ║   ║3
#╚═══╩═══╝
#Below is the grid variable, which is an array that contains 4 2 sized arrays, all containing the above
#'gridInfo' dictionary. To reference a specific grid space, follow the chart above. AKA to get info about tile 
#1,2, you would write grid[1][2]["key"]


var grid =	 [[gridInfo.duplicate(false), gridInfo.duplicate(),
 			 gridInfo.duplicate(false), gridInfo.duplicate()], 
			 [gridInfo.duplicate(false), gridInfo.duplicate(),
			 gridInfo.duplicate(false), gridInfo.duplicate()]]



func _ready() -> void: 
	ConstructGrid()



#A function to get the position of the grid, perhaps a bit cleaner than typing grid[x][y][key]
func getGridPos(x: int, y: int, key: String):
	return grid[x][y][key]

#A function to set the position of a tile in the grid, perhaps a bit cleaner than typing grid[x][y][key] = dwa
func setGridPos(x: int, y: int, key: String, value):
	grid[x][y][key] = value


#Function used to construct the grid at combat start.
func ConstructGrid() -> void:
	#Loops through all characters to place them
	for i in characters.size():
		#Update grid to contain character. This already lookin a bit messy
		if getGridPos(characters[i].gridPos[0], characters[i].gridPos[1], "character") == null:
			setGridPos(characters[i].gridPos[0], characters[i].gridPos[1], "character", characters[i])
			MoveCharacter(i) #Moves current character


func MoveCharacter(character) -> void:
	characters[character].position = get_node(str(characters[character].gridPos[0], characters[character].gridPos[1])).position
