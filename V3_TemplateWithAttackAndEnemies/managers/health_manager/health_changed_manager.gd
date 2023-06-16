extends Control
class_name HealthChangeManager

@export var health_indicator : PackedScene
@export var damage_color : Color = Color.RED
@export var heal_color : Color = Color.GREEN


func _ready():
	SignalBus.health_changed.connect(on_health_changed)
	
func on_health_changed(node: Node, amount_changed: int):
	var label_instance : Label = health_indicator.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	label_instance.modulate = damage_color if amount_changed >= 0 else heal_color
