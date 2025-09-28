extends CharacterBody2D
@export var max_health: int = 1
var health: int = max_health
var invincible: bool = false
  # hasar sonrası kısa ölümsüzlük
var inv_timer: float = 0.0




@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var speed: float = 350.0
var jump_force: float = -550.0
var gravity: float = 700.0

func _ready() -> void:
	# Eğer doğrudan $AnimatedSprite2D bulunamazsa null olur; o zaman hiyerarşide arayalım:
	if anim == null:
		anim = _find_animated_sprite2d(self)
	# Hâlâ yoksa açıkça hata verelim:
	assert(anim != null, "AnimatedSprite2D bulunamadı. Script'i CharacterBody2D'ye tak ve altında AnimatedSprite2D olduğundan emin ol (adı farklıysa da sorun değil, kod tipine göre bulacak).")

func _set_anim(val: AnimatedSprite2D) -> void:
	anim = val

func _physics_process(delta: float) -> void:
	# Yerçekimi
	if not is_on_floor():
		velocity.y += gravity * delta

	# Girişler (Input Map yok; W/A/D)
	var input_x: float = 0.0
	if Input.is_key_pressed(KEY_A):
		input_x -= 2.0
	if Input.is_key_pressed(KEY_D):
		input_x += 2.0

	velocity.x = input_x * speed

	# Zıplama (W) – sadece yerdeyken
	if Input.is_key_pressed(KEY_W) and is_on_floor():
		velocity.y = jump_force

	# anim null değilse güvenle kullan
	if anim != null:
		# Yön çevirme (flip_h)
		if input_x != 0:
			anim.flip_h = input_x < 0

		# Animasyon seçimi
		if not is_on_floor():
			anim.play("jump")
		elif input_x != 0:
			anim.play("run")
		else:
			anim.play("idle")

	move_and_slide()

# --- Yardımcı: Ağaçta tipine göre AnimatedSprite2D bulur (ad önemli değil) ---
func _find_animated_sprite2d(node: Node) -> AnimatedSprite2D:
	for c in node.get_children():
		if c is AnimatedSprite2D:
			return c
		var found := _find_animated_sprite2d(c)
		if found != null:
			return found
	return null






func die():
	get_tree().reload_current_scene()
