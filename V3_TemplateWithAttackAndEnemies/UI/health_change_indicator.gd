extends Label
class_name HealthChangeIndicator

@export var float_speed : Vector2

func _ready():
	float_speed = Vector2(randi_range(-20,20),randi_range(40,70))
	
func _process(delta):
	position += -float_speed * delta
	await get_tree().create_timer(0.5).timeout
	queue_free()
