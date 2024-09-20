extends Marker2D

@export var hit_node : PackedScene

func _ready():
	randomize()

func popup(number: int):
	var hit = hit_node.instantiate()
	hit.position = global_position
	hit.get_child(0).text = str(number)
	
	var tween = get_tree().create_tween()
	tween.tween_property(hit, "position", global_position + _get_direction(), 0.75)
	
	get_tree().current_scene.add_child(hit)

func _get_direction():
	return Vector2(randf_range(-1,1), randf()) * 16
