extends CharacterBody2D  # Node2D değil, Area2D yap

@export var speed: float = 400.0
@export var start_point: NodePath
@export var end_point: NodePath
@export var player_path: NodePath

var direction = Vector2.ZERO
var target_position = Vector2.ZERO
var player

func _ready():
	global_position = get_node(start_point).global_position
	target_position = get_node(end_point).global_position
	direction = (target_position - global_position).normalized()
	
	player = get_node(player_path)
	
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	global_position += direction * speed * delta
	
	if global_position.distance_to(target_position) < 5.0:
		global_position = get_node(start_point).global_position

func _on_body_entered(body):
	if body == player:
		# Oyuncuyu başlangıca ışınla
		player.global_position = get_node(start_point).global_position
