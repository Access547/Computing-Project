extends Node2D

var gridInfo = {"character": null,
				"targeted": true,
				"effect": null}



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
#1,2, you would say grid[1][2]["key"]


var grid =	 [[gridInfo.duplicate(false), gridInfo.duplicate(),
 			gridInfo.duplicate(false), gridInfo.duplicate()], 
			 [gridInfo.duplicate(false), gridInfo.duplicate(),
			 gridInfo.duplicate(false), gridInfo.duplicate()]]



func _ready():
	grid[0][0]["targeted"] = false
	
	print (grid[0][0]["targeted"])
	print(grid[0][1]["targeted"])
