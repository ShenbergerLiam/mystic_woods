extends Node2D

var score = 0
func _on_enemy_died(value):
	score += value
	$CanvasLayer/UI.update_score(score)
