extends Node2D

var ball_resource = preload("res://scenes/ball.tscn")
var ball :CharacterBody2D = null
@onready var audio = $simple_audio

func _ready():
	ball = generate_ball()

	
func generate_ball() -> CharacterBody2D:
	ball = ball_resource.instantiate()
	ball.ball_exited.connect(_on_ball_exited)
	ball.position = Vector2(600,300)
	add_child(ball)
	return ball
	
func _on_ball_exited():
	if ball.position.x < 10 :
		get_node("UI").increase_score(2)
		audio.play_sound("aw_sound")
	else:
		var velocity = ball.velocity * -1
		get_node("UI").increase_score(1)
		audio.play_sound("yay_sound")
	remove_child(ball)
	ball.queue_free()
	ball = generate_ball()
	
