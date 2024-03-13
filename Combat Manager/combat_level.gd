extends Node2D

var gridInfo = {"character": null,
				"targeted": true,
				"effect": null}


var turn: int = 1
var turnOrder: Array[Character] #This needs to be populated automatically using some sort of speed stat!



@export var characters: Array[Character]
@export var enemies: Array[Character]



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

var grid =	 [[gridInfo.duplicate(false), gridInfo.duplicate(false),
 			 gridInfo.duplicate(false), gridInfo.duplicate(false)], 
			 [gridInfo.duplicate(false), gridInfo.duplicate(false),
			 gridInfo.duplicate(false), gridInfo.duplicate(false)]]



func _ready() -> void:
	ConstructGrid()
	turnOrder.append_array(get_tree().get_nodes_in_group("Combatant"))
	print(turnOrder[0])
	enemies.append_array(get_tree().get_nodes_in_group("Enemy"))
	
	for i in enemies.size():
		SetGridEffect(enemies[i].nextAttack, enemies[i])



#A function to get the position of the grid, perhaps a bit cleaner than typing grid[x][y][key]
func getGridPos(x: int, y: int, key: String) -> Variant:
	return grid[x][y][key]

#A function to set the position of a tile in the grid, perhaps a bit cleaner than typing grid[x][y][key] = dwa
func setGridPos(x: int, y: int, key: String, value):
	grid[x][y][key] = value

func GetCharacterGridPosAsString(character) -> String:
	return str(character.gridPos[0], character.gridPos[1])
	
func GetCharacterGrosPosAsVector(character) -> Vector2:
	return Vector2(character.gridPos[0], character.gridPos[1])
	


#Function used to construct the grid at combat start.
func ConstructGrid() -> void:
	#Loops through all characters to place them
	for i in characters.size():
		#Update grid to contain character. This already lookin a bit messy
		if getGridPos(characters[i].gridPos[0], characters[i].gridPos[1], "character") == null:
			setGridPos(characters[i].gridPos[0], characters[i].gridPos[1], "character", characters[i])
			MoveCharacter(characters[i]) #Moves current character


#Moves the character physically in space
func MoveCharacter(character) -> void:
	character.position = get_node(GetCharacterGridPosAsString(character)).position


#Sets the grid effect of a tile. A grid effect is how enemies damage players by creating hazards on grid tiles
func SetGridEffect(effect: DamageEffect, owner: Enemy) -> void:
	var newKey = str(owner, "damage")
	for i in effect.tiles.size():
		grid[effect.tiles[i].x][effect.tiles[i].y][newKey] = effect



func ActivateGridEffect(tile: Dictionary, enemy: Character):
	tile["character"].health -= tile[str(enemy, "damage")].damageAmount
	print(tile["character"].health)



func _on_button_pressed() -> void:
	ResolveTurn()
	ActivateGridEffect(grid[1][1], get_tree().get_first_node_in_group("Enemy"))


	
#Passes the turn on a character and onto the next character
func ResolveTurn() -> void:
	turnOrder.pop_front()
	print(turnOrder[0].name)




func _on_attack_pressed():
	enemies[0].health -= turnOrder[0].damage
	ResolveTurn()
