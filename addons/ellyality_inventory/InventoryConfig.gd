class_name InventoryConfig extends Resource

enum InventoryType {
	List,
	Shape,
	Grid
}

@export_category("Config")
@export var ApplyWeight:bool = true
@export var CarryOverWeight:bool = false
@export_category("Data")
@export var Type:InventoryType
@export var Row:int = 10
@export var WeightLimit:int = 100
@export var Slot:int = 40

## The owner node for this inventory
var _owner:Node
var _contents:Array[ItemStack]

func SetOwner(n:Node):
	_owner = n

func AddItem(item:ItemConfig, count:int = 1, slot:int = -1) -> bool:
	return true
	
func MoveItem(from:int, to:int) -> bool:
	return true

## Get the item instance from the inventory content base on [param slot] [br]
## The return value could be null, if the item position is empty
func GetItem(slot:int) -> ItemStack:
	for c in _contents:
		if Type == InventoryType.List:
			if c.Slot == slot: 
				return c	
		else:
			var pos = c.Item.GetPositions(self, c.Slot)
			for p in pos:
				if (p.y * Row) + p.x == slot:
					return c
	return null

## Check target [param slot] has item on it
func HasItem(slot:int):
	return GetItem(slot) != null

## Remove the item from the inventory content base on [param slot] position [br]
## Remove the entire item ignore the amount if the count is negative value
func RemoveItem(slot:int, count:int = -1):
	for i in _contents.size():
		var c = _contents[i]
		if Type == InventoryType.List:
			if c.Slot == slot:
				if count < 0:
					_contents.remove_at(i)
					return true
				else:
					c.Amount = c.Amount - count
					if c.Amount <= 0:
						_contents.remove_at(i)
						return true
		else:
			var pos = c.Item.GetPositions(self, c.Slot)
			for p in pos:
				if (p.y * Row) + p.x == slot:
					if count < 0:
						_contents.remove_at(i)
						return true
					else:
						c.Amount = c.Amount - count
						if c.Amount <= 0:
							_contents.remove_at(i)
							return true
	return false

func TotalWeight() -> int:
	var count = 0
	for c in _contents:
		count += c.GetWeights()
	return count

func IsOverWeight() -> bool:
	return TotalWeight() <= WeightLimit

func AvailableSpace() -> Array[int]:
	var result:Array[int] = []
	for i in range(Slot):
		result.append(i)
	for c in _contents:
		if Type == InventoryType.List:
			result.erase(c.Slot)
		else:
			var pos = c.Item.GetPositions(self, c.Slot)
			for p in pos:
				var cell = (p.y * Row) + p.x
				result.erase(cell)
	return result

func CheckQuickMove(itemstack:ItemStack) -> bool:
	return true

func CheckVaild(slots:Array[int]) -> bool:
	return true
	
func CheckOverlap(slots:Array[int]) -> bool:
	return true
