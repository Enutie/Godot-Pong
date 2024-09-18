extends Node2D

var ball_resource = preload("res://scenes/ball.tscn")
var ball :CharacterBody2D = null

func _ready():
	ball = generate_ball()

	
func generate_ball() -> CharacterBody2D:
	ball = ball_resource.instantiate()
	ball.ball_exited.connect(_on_ball_exited)
	add_child(ball)
	ball.position = Vector2(600,300)
	return ball
	
func _on_ball_exited():
	print("Ball left the game at position:" , ball.position)
	remove_child(ball)
	ball.queue_free()
	
