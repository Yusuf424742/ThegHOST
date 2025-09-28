extends Node2D

var dialogue_active = false
var dialogue_lines = [
	"Sen: Merhaba!",
	"NPC: Hoş geldin!"
]
var current_line = 0

func _ready():
	$DialogueBalloon.visible = false
	$Player.connect("area_entered", Callable(self, "_on_player_area_entered"))
	$Player.connect("area_exited", Callable(self, "_on_player_area_exited"))

func _process(delta):
	if dialogue_active and Input.is_action_just_pressed("ui_accept"):
		advance_dialogue()

func _on_player_area_entered(area):
	if area == $NPC and not dialogue_active:
		start_dialogue()

func _on_player_area_exited(area):
	if area == $NPC:
		end_dialogue()

func start_dialogue():
	dialogue_active = true
	current_line = 0
	$DialogueBalloon.show_text(dialogue_lines[current_line])

func advance_dialogue():
	if $DialogueBalloon.is_typing:
		$DialogueBalloon.skip_or_finish()
	else:
		current_line += 1
		if current_line >= dialogue_lines.size():
			end_dialogue()
		else:
			$DialogueBalloon.show_text(dialogue_lines[current_line])

func end_dialogue():
	dialogue_active = false
	$DialogueBalloon.visible = false
