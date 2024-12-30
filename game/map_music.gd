extends Node

func change_music(i: int) -> void:
	if i == 1:
		$GreggsSmasher.stop()
		$RumRoad.play()
	if i == 2:
		$RumRoad.stop()
		$ColdfishLabyrinth.play()
