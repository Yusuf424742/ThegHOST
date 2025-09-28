extends RichTextLabel

var dialogue_line = ""
var is_typing = false
var typing_speed = 0.05
var typing_timer = 0.0

@onready var label = $Label

func show_text(text):
	dialogue_line = text
	visible_characters = 0
	typing_timer = 0
	is_typing = true
	label.text = ""
	visible = true

func _process(delta):
	if is_typing:
		typing_timer += delta
		if typing_timer >= typing_speed:
			typing_timer = 0
			visible_characters += 1
			label.text = dialogue_line.substr(0, visible_characters)
			if visible_characters >= dialogue_line.length():
				is_typing = false

func skip_or_finish():
	if is_typing:
		is_typing = false
		label.text = dialogue_line
	else:
		visible = false
