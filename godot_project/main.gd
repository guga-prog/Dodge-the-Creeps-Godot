extends Node

@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
@export var boss_scene: PackedScene
const tempo_fases = 11
var score = 0
var mobs = 0
var coins = 0
var tempo_fase_atual = 20
var x = 0
var game_status = false
var boss_atual = null
enum State {COLETA, BOSS}
var fase_atual = State.COLETA

func disable_hud():
	$HUD/ScoreLabel.hide()
	$HUD/TimerLabel.hide()
	$HUD/Tempo_restante.hide()
	$HUD/Coin.hide()
	
func active_hud():
	$HUD/ScoreLabel.show()
	$HUD/TimerLabel.show()
	$HUD/Tempo_restante.show()
	$HUD/Coin.show()
	
func game_over():
	Main.game_status = false
	$MobTimer.stop()
	$CoinTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$PhaseTimer.stop()
	get_tree().call_group("Coin", "queue_free")
	if fase_atual == State.BOSS:
		_on_phase_timer_timeout()
		phase_timeout()
	disable_hud()


func new_game():
	get_tree().call_group(&"mobs", &"queue_free")
	Main.mobs = 0
	Main.coins = 0
	score = 0
	Main.game_status = true
	fase_atual = State.COLETA
	$Player.start($StartPosition.position)
	$PhaseTimer.set_wait_time(tempo_fases)
	$HUD.update_score(score)
	$HUD.update_timer(tempo_fase_atual)
	active_hud()
	$HUD.show_message("Get Ready")
	$SpawnSound.play()
	$Music.play()
	await get_tree().create_timer(1).timeout
	get_tree().call_group("Coin", "queue_free")
	boss_timeout()
	$PhaseTimer.start()

func boss_timeout():
	$MobTimer.start()
	$CoinTimer.start()

func _on_MobTimer_timeout():
	if Main.mobs < 15:
		Main.mobs +=1
	
	# Create a new instance of the Mob scene.
		var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
		var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
		mob_spawn_location.progress = randi()

	# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction

	# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(225.0, 300.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
		add_child(mob)
	
func _on_CoinTimer_timeout():
	if Main.coins < 5:
		Main.coins += 1
	# Create a new instance of the Mob scene.
		var coin = coin_scene.instantiate()
		var random_x = 0
		var random_y = 0
	# Choose a random location on Path2D.
		if randf() <= 0.7: 
			random_x = randf_range(167,315 * 1.5)
			random_y = randf_range(243,481 * 1.5)
		else:
			random_x = randf_range(20,400 * 1.5)
			if random_x > 167 and random_x < 315 * 1.5:
				if randf() > 0.5:
					random_y = randf_range(20,300)
				else: 
					random_y = randf_range(700,900)
			else:
				random_y = randf_range(20,900)
	# Set the mob's position to a random location.
		coin.global_position = Vector2(random_x, random_y)

	# Spawn the mob by adding it to the Main scene.
		add_child(coin)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$CoinTimer.start()

func phase_timeout():
	$MobTimer.stop()
	$CoinTimer.stop()
	
func _on_phase_timer_timeout():
	x += 2
	if fase_atual == State.COLETA:
		fase_atual = State.BOSS
		if Main.score / $PhaseTimer.get_wait_time() >= 0.7:
			pass
		elif Main.score / $PhaseTimer.get_wait_time() <= 0.3:
			pass
		else:
			pass
		$PhaseTimer.set_wait_time(tempo_fases + x)
		boss_atual = boss_scene.instantiate()
		boss_atual.global_position = Vector2(100,100)
		add_child(boss_atual)
		phase_timeout()
		$HUD.mostrar_fase(fase_atual)
		$PhaseTimer.start()
		
	elif fase_atual == State.BOSS:
		$PhaseTimer.set_wait_time(tempo_fases + x / 2)
		var boss_spawn_location = get_node(^"MobPath/MobSpawnLocation")
		boss_spawn_location.progress = randi()
		var direction = boss_spawn_location.rotation + PI / 2
		direction += randf_range(-PI / 4, PI / 4)
		boss_atual.rotation = direction
		var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
		boss_atual.linear_velocity = velocity.rotated(direction)
		fase_atual = State.COLETA
		boss_timeout()
		$HUD.mostrar_fase(fase_atual)
		$PhaseTimer.start()
		
func _on_player_hit_coin() -> void:
	score +=1
	$HUD.update_score(score) # Replace with function body.

func is_coin_position_valid(new_position: Vector2) -> bool:
	for coin in get_tree().get_nodes_in_group("coins"):
		if coin.global_position.distance_to(new_position) < 32:
			return false
	return true
