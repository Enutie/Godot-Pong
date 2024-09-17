extends RigidBody2D

var velocity = Vector2.ZERO()
export var speed = 200

func _ready():
	   set_velocity(Vector2(100,0))

func _physics_process(delta):
	  var collision_info = move_and_collide(velocity * speed * delta)
	  if collision_info:
			velocity = velocity.bounce(collision_info) 
