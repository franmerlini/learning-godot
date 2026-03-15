extends Area2D

class_name Dice

signal off_screen

@onready var sprite_2d: Sprite2D = $Sprite2D

const MOVEMENT_SPEED: float = 80.0
const ROTATION_SPEED: float = 5.0
var rotation_direction: float = 1.0

func _ready() -> void:
	if randf() < 0.5: rotation_direction *= -1

func _physics_process(delta: float) -> void:
	position.y += delta * MOVEMENT_SPEED
	sprite_2d.rotate(delta * ROTATION_SPEED * rotation_direction)
	check_off_screen()

func check_off_screen() -> void:
	if get_viewport_rect().end.y < position.y:
		off_screen.emit()
		queue_free()
