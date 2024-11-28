extends Control

func _on_play_pressed() -> void:
	pass # Replace with function body.

func _on_how_to_play_pressed() -> void:
	pass # Replace with function body.


func _on_fullscreen_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen

func _on_credits_pressed() -> void:
	get_tree().change_scene("res://credit.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
