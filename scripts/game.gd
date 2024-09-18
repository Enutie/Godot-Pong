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
	if ball.position.x < 10 :
		get_node("UI").increase_score(2)
	else:
		get_node("UI").increase_score(1)
	remove_child(ball)
	ball.queue_free()
	ball = generate_ball()
	
