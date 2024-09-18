extends CharacterBody2D

signal ball_exited

var speed = 500

func _ready() -> void:
	velocity = Vector2(-250,-250).normalized() * speed
	
func _physics_process(delta: float) -> void:
	print("Position:", position)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
