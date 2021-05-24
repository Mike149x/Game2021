extends Weapon

export var fire_range = 10

onready var raycast = $"../Head/Camera/RayCast"

func _ready():
	raycast.cast_to = Vector3(0, 0, -fire_range)







