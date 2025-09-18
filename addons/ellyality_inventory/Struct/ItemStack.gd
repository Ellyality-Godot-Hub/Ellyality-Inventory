class_name ItemStack extends Resource

@export var Item:ItemConfig
@export var Amount:int
var Slot:int

func GetWeights() -> int:
	return Item.weight * Amount
