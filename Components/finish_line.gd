extends Area2D

@onready var stream_player = $AudioStreamPlayer
var finished_already = false

func _on_body_entered(body: Node2D) -> void:
	if !finished_already:
		stream_player.play(0)
		finished_already = true
