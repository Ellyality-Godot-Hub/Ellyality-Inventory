class_name RangeWeapon extends WeaponBase

enum RangeTypp {
	Pistol,
	Rifle,
	ShotGun,
	Sniper,
	MachineGun,
	Launcher,
}

@export var Type:RangeTypp = RangeTypp.Rifle
@export_flags("Manual:1", "Three:2", "Auto:4") var FireMode:int = 0
@export var Ammo:int = 30
@export_range(0.1, 5.0) var Accuracy:float = 5
@export_range(0.1, 5.0) var Stability:float = 5
@export_range(0.1, 5.0) var FireRate:float = 5
@export_range(0.1, 10.0) var ChargeTime:float = 5
@export_range(0.1, 10.0) var ReloadTime:float = 5
