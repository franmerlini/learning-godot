extends Node2D

const DICE = preload('res://Scenes/Dice/Dice.tscn')

@onready var spanw_timer: Timer = $SpawnTimer

const MARGIN: float = 80.0
const STOPPABLE_GROUP_KEY: String = 'stoppable'

func _ready() -> void:
	spanw_timer.start(2)
	spawn_dice()

func spawn_dice() -> void:
	var new_dice: Dice = DICE.instantiate()
	var vpr: Rect2 = get_viewport_rect()
	var x_position = randf_range(vpr.position.x + MARGIN, vpr.end.x - MARGIN)
	new_dice.position = Vector2(x_position, -MARGIN)
	new_dice.off_screen.connect(_on_dice_off_screen)
	add_child(new_dice)

func pause_all() -> void:
	spanw_timer.stop()
	var nodes_to_stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE_GROUP_KEY)
	for node in nodes_to_stop:
		node.set_physics_process(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _on_spawn_timer_timeout() -> void:
	spawn_dice()

func _on_dice_off_screen() -> void:
	pause_all()
