extends Node2D

var ball = preload("res://scenes/ball.tscn")
signal goal

func _ready():
	ball = generate_ball()
	# ball.connect(add_score) this wont compile
	
	
func _process(delta: float) -> void:
	pass
	
func generate_ball() -> CharacterBody2D:
	var instance = ball.instantiate()
	add_child(instance)
	return instance

func add_score():
	print("Someone got a point!")
