extends Sprite2D
class_name Character


@export var gridPos: Array[int]
@export var charName: String
@export var maxHealth: int
@export var damage: int

var health: int


func _ready():
	health = maxHealth
	print(name)


func _process(_delta):
	if health <= 0:
		visible = true
