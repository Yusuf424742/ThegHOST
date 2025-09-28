extends CharacterBody2D

@onready var target = get_node("../İnsan")
var max_speed = 150

func _physics_process(delta):
	if target:
		var to_target = target.position - position
		var distance = to_target.length()
		var direction = to_target.normalized()
		
		# Mesafe yakınsa hızını azalt
		var speed = max_speed
		if distance < 100:
			speed = lerp(0, max_speed, distance / 100)
		
		velocity = direction * speed
		look_at(target.position)
		move_and_slide()
