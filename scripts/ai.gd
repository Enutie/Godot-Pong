extends CharacterBody2D

var player_speed: float = 200.0  
var speed_factor: float = 0.95  
var reaction_delay: float = 0.2 
var accuracy: float = 0.8  
var last_move_time: float = 0.0  

var screen_height: float
var paddle_height: float

func _ready():
	print("AI paddle initialized")
	
	screen_height = get_viewport_rect().size.y
	paddle_height = $CollisionShape2D.shape.extents.y * 2  
func _physics_process(delta: float):
	last_move_time += delta
	
	
	if last_move_time >= reaction_delay:
		last_move_time = 0.0
		

func move(target_position: float):
	
	var inaccuracy = randf_range(-50, 50) * (1.0 - accuracy)
	var adjusted_target = target_position + inaccuracy
	
	
	var direction = adjusted_target - position.y
	var distance = abs(direction)
	
	var ai_speed = player_speed * speed_factor
	
	
	var movement = clamp(distance, 0, ai_speed * get_physics_process_delta_time())
	movement *= sign(direction)
	
	
	var new_y = position.y + movement
	
	#
	new_y = clamp(new_y, paddle_height / 2, screen_height - paddle_height / 2)
	
	
	position.y = new_y


func adjust_difficulty(new_speed_factor: float, new_delay: float, new_accuracy: float):
	speed_factor = new_speed_factor
	reaction_delay = new_delay
	accuracy = new_accuracy

func update_player_speed(new_player_speed: float):
	player_speed = new_player_speed
