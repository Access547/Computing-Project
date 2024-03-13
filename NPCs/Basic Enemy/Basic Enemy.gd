extends Enemy



func _ready():
	nextAttack = attacks.pick_random()
