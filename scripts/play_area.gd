extends Area2D

func _on_body_exited(body: Node2D) -> void:
	print("Ball Left:", body)
	body.ball_exited.emit()
	
