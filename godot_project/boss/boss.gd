extends Node2D

@export var follow_path: PathFollow2D
@export var follow_velocity: float = 100.0
@export var bullet_scene: PackedScene
@export var bullet_velocity: float = 100.0
@export var bullet_amount: int = 1
@export var bullet_target: Marker2D
@export_enum("Perpendicular", "Radial", "Targeted") var bullet_type: String = "Perpendicular"

var follow_direction: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	follow_path.progress += follow_velocity * delta
	var new_position = follow_path.position
	follow_direction = position.direction_to(new_position)
	position = new_position

func spawn() -> void:
	for i in bullet_amount:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		var angle = get_bullet_angle(i)
		bullet.rotation = angle
		bullet.linear_velocity = bullet_velocity * Vector2.from_angle(angle)
		get_tree().root.call_deferred("add_child", bullet)

func get_bullet_angle(bullet_index: int) -> float:
	match bullet_type:
		"Perpendicular":
			return get_perpendicular_bullet_angle()
		"Radial":
			return get_radial_bullet_angle(bullet_index)
		"Targeted":
			return get_targeted_bullet_angle()
	return 0

func get_perpendicular_bullet_angle() -> float:
	var viewport_rect = get_viewport_rect()
	var viewport_center = viewport_rect.size / 2
	var direction_to_center = global_position.direction_to(viewport_center)
	var perpendicular = follow_direction.rotated(PI / 2) 
	if perpendicular.dot(direction_to_center) < 0:
		perpendicular *= -1
	return perpendicular.angle()
		
func get_radial_bullet_angle(bullet_index: int) -> float:
	var bullet_section = 2 * PI
	return bullet_index * bullet_section / bullet_amount
		
func get_targeted_bullet_angle() -> float:
	var direction_to_target = global_position.direction_to(bullet_target.global_position)
	return direction_to_target.angle()
