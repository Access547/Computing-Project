extends Sprite2D
class_name Character


@export var gridPos: Array[int]
@export var charName: String
@export var maxHealth: int

var health: int


func _ready():
	health = maxHealth
