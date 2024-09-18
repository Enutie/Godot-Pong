extends Control

@onready var player1 = get_node("Player1Label")
@onready var player2 = get_node("Player2Label")
var player1_score = 0
var player2_score = 0

func increase_score(player):
	if player == 1:
		player1_score += 1
		player1.text = str(player1_score)
	else:
		player2_score += 1
		player2.text = str(player2_score)
		
