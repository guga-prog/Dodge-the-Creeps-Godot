extends Area2D

signal hit
signal hit_coin


@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size * 1.75
	hide()


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		if $MoveSound.playing == false and Main.game_status == true:
			$MoveSound.play()
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$MoveSound.playing = false
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = &"right"
		$AnimatedSprite2D.flip_v = false
		$Trail.rotation = 0
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = &"up"
		rotation = PI if velocity.y > 0 else 0


func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered_mob(_body):
	if _body.is_in_group("Mob"):
		hide() # Player disappears after being hit.
		hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred(&"disabled", true)
	elif _body.is_in_group("Coin"):
		_body.hide()
		hit_coin.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
		_body.get_node("CollisionShape2D").set_deferred(&"disabled", true)
		
