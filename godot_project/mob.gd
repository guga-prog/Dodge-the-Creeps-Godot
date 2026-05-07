extends RigidBody2D

func _ready():
	add_to_group("Mob")
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	Main.mobs-=1
