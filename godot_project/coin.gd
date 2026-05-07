extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC)	
	tween.tween_property($AnimatedSprite2D, "scale", $AnimatedSprite2D.scale , 1.0).from(Vector2())
	add_to_group("Coin")
	$Sumir.timeout.connect(queue_free)
	$Sumir.start()


func _on_VisibilityNotifier2D_screen_exited():
	Main.coins -= 1
	queue_free()


func _on_timer_timeout():
	$AnimatedSprite2D.play()


func _on_animated_sprite_2d_animation_finished():
	$Timer.wait_time = randf_range(1.0, 5.0)
	$Timer.start()


func _on_sumir_timeout() -> void:
	Main.coins -= 1 
