extends CharacterBody2D

signal ball_exited
signal ball_hit

var speed = 500
var sfx = [
	preload("res://assets/sounds/SFX/bing.ogg"),
	preload("res://assets/sounds/SFX/ping.ogg"),
	 preload("res://assets/sounds/SFX/boing.ogg"),
	preload("res://assets/sounds/SFX/bop.ogg"),
	 preload("res://assets/sounds/SFX/whosh.ogg")
]

func _ready() -> void:
	velocity = Vector2(-250,-250).normalized() * speed
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		AudioPlayer.play_FX(sfx[randi() % 5])
		self.ball_hit.emit()
		velocity = velocity.bounce(collision.get_normal())
		
