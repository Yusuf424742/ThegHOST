extends Area2D

func _ready() -> void:
	body_entered.connect(self._on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		# Aktif sahneyi yeniden yükle = restart
		var current_scene = get_tree().current_scene
		get_tree().reload_current_scene()
