extends CanvasLayer
@export var node_path: NodePath
var node
signal start_game
func _ready() -> void:
	node = get_node(node_path)
func _process(delta):
	$TimerLabel.text = str(int(node.get_time_left()))
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$MessageLabel.text = "Dodge the\nCreeps"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)
func update_timer(tempo):
	$TimerLabel.text = str(tempo)
func mostrar_fase(fase_atual):
	if fase_atual == Main.State.COLETA:
		show_message("Fase Coleta")
		await get_tree().create_timer(1).timeout
	else:
		show_message("Fase Boss")
		await get_tree().create_timer(1).timeout
func _on_StartButton_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
