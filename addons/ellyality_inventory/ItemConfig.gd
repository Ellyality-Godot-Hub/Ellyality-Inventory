class_name ItemConfig extends Resource

@export var Name:String
@export var Icon:Texture2D
@export var StackLimit:int = 1
@export var weight = 1
@export var extraSpace:Array[Vector2i]

## Get position array from [param inven] base on input [param slot] position. [br]
## This will only apply for Grid and Shape type of inventory. [br]
## Vector result x and y statt at 0.
##
## [codeblock]
## # Example: row: 10, size: 30
## var p = GetPositions(player, 25)
## # p = [5, 2]
## [/codeblock]
func GetPositions(inven:InventoryConfig, slot:int) -> Array[Vector2i]:
	if inven.Type == InventoryConfig.InventoryType.List:
		return []
	# Example: row: 10, size: 30, 
	# 25 -> [5, 2] 
	# 0 -> [0, 0]
	# 9 -> [9, 0]
	var og:Vector2i = Vector2i(slot % inven.Row, floor(slot / inven.Row))
	var result:Array[Vector2i] = [og]
	
	if extraSpace.size() == 0:
		return result
	
	for space in extraSpace:
		result.append(Vector2i(og.x + space.x, og.y + space.y))
		
	# Filtering out the invaild part
	for i in range(result.size() -1, -1, -1):
		# Check x is over limit
		if result[i].x >= inven.Row or result[i].x < 0:
			result.remove_at(i)
			continue
		# Check slot is in the range
		var s:int = (result[i].y * inven.Row) + result[i].x
		if s >= inven.Slot or s < 0:
			result.remove_at(i)
			continue
	return result
