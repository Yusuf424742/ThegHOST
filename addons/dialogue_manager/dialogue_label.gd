# DialogueManager.gd
extends Node

@export var dialogue_label_path: NodePath
var dialogue_label: DialogueLabel

var dialogue_lines: Array = []
var current_index := 0
var auto_advance := false # Otomatik geçsin mi?

func _ready():
	dialogue_label = get_node(dialogue_label_path)
	dialogue_label.finished_typing.connect(_on_finished_typing)

func start_dialogue(lines: Array, auto_advance_enabled := false) -> void:
	dialogue_lines = lines
	current_index = 0
	auto_advance = auto_advance_enabled
	play_next()

func play_next() -> void:
	if current_index >= dialogue_lines.size():
		print("✅ Diyalog bitti.")
		return

	var line = dialogue_lines[current_index]
	dialogue_label.dialogue_line = {
		"text": line.get_full_text("Sen:Burası da Neresi Kendimi Aniden Burda Buldum ve Hiç Bir Şey Hatırlamıyorum
Gizemli İnsan:Sen [wait=1] Sen De Onlardan Birisin
Sen:Anlamıyorum ne diyorsun birdenbire burada uyandım ve cebimde 3 anahtar buldum ve sen neden hep öyle hareket ediyorsun
Gizemli İnsan:Bana 1 anahtarı ver sana ne olduğunu anlatayim"),
		"pauses": line.pauses,
		"speeds": line.speeds,
		"inline_mutations": line.inline_mutations,
		"extra_game_states": line.extra_game_states
	}
	dialogue_label.type_out()
	current_index += 1

func _on_finished_typing():
	if auto_advance:
		await get_tree().create_timer(1.0).timeout
		play_next()

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if dialogue_label.is_typing:
			dialogue_label.skip_typing()
		else:
			play_next()
