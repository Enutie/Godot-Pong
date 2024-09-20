extends Node2D

var ball_resource = preload("res://scenes/ball.tscn")
var aw = preload("res://assets/sounds/SFX/aaaw.ogg")
var yay = preload("res://assets/sounds/SFX/yay.ogg")
@onready var ai = get_node("Player2")
var ball: CharacterBody2D = null
var hit_counter := 0
var color_rect: ColorRect
var initial_ball_speed := 400.0  
var speed_increase_factor := 1.05  
var pastel_colors = [
	 Color("5F9EA0"),  # Muted Teal
	Color("A17C7C"),  # Dusty Rose
	Color("7C9A92"),  # Sage Green
	Color("4A6B8A"),  # Muted Navy
	Color("8E7F8D")   # Soft Plumple
]
var shake_tween: Tween = null
var original_offset: Vector2 = Vector2.ZERO

func _ready():
	AudioPlayer.play_music()
	color_rect = get_node("Play Area/ColorRect")
	set_initial_background_color()
	ball = generate_ball()
	original_offset = get_viewport().canvas_transform.origin
	ai.adjust_difficulty(1.0,1.0,0.9)

func _process(delta: float) -> void:
	var position = ball.position.y * 1.5
	ai.move(position)

func set_initial_background_color():
	color_rect.color = pastel_colors[0]

func generate_ball() -> CharacterBody2D:
	ball = ball_resource.instantiate()
	ball.ball_exited.connect(_on_ball_exited)
	ball.ball_hit.connect(_on_ball_hit)
	ball.position = Vector2(600, 300)
	
	var initial_velocity = Vector2(initial_ball_speed, 0).rotated(randf_range(-PI/4, PI/4))
	ball.velocity = initial_velocity
	
	add_child(ball)
	return ball

func _on_ball_hit():
	hit_counter += 1
	$PopupLocation.popup(hit_counter)
	update_background()
	increase_ball_speed()

func increase_ball_speed():
	var current_speed = ball.velocity.length()
	var new_speed = current_speed * speed_increase_factor
	ball.velocity = ball.velocity.normalized() * new_speed

func _on_ball_exited():
	if ball.position.x < 10:
		get_node("UI").increase_score(2)
		AudioPlayer.play_FX(aw)
	else:
		get_node("UI").increase_score(1)
		AudioPlayer.play_FX(yay)
	hit_counter = 0
	remove_child.call_deferred(ball)
	ball.queue_free()
	ball = generate_ball()

func update_background():
	var new_color: Color
	var pulse_strength = 0.2
	var pulse_duration = 0.3

	if hit_counter > 20:
		new_color = pastel_colors[4]  
		pulse_strength = 0.4
		pulse_duration = 0.2
	elif hit_counter > 15:
		new_color = pastel_colors[3]
		pulse_strength = 0.3
	elif hit_counter > 10:
		new_color = pastel_colors[2]
	elif hit_counter > 5:
		new_color = pastel_colors[1]
	else:
		new_color = pastel_colors[0]

	var tween = create_tween()
	tween.tween_property(color_rect, "color", new_color.lightened(pulse_strength), pulse_duration)
	tween.tween_property(color_rect, "color", new_color, pulse_duration)

	if hit_counter > 15:
		screen_shake(5, 0.2)

func screen_shake(amount: float, duration: float):
	var viewport = get_viewport()
	if viewport:
		if shake_tween and shake_tween.is_valid():
			shake_tween.kill()

		shake_tween = create_tween()

	shake_tween.tween_property(viewport, "canvas_transform:origin", 
		original_offset + Vector2(randf_range(-amount, amount), randf_range(-amount, amount)), 
		duration / 2.0)

	shake_tween.tween_property(viewport, "canvas_transform:origin", 
		original_offset, 
		duration / 2.0)

	shake_tween.connect("finished", Callable(self, "_on_shake_finished"))

func _on_shake_finished():
	get_viewport().canvas_transform.origin = original_offset
