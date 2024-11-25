extends CharacterBody2D


@export var gravity: float = 1800.0
@export var jump_speed: float = 800.0
@export var walk_speed: float = 300.0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = -jump_speed
	else:
		velocity.y += gravity * delta
	
	velocity.x = Input.get_axis("move_left", "move_right") * walk_speed
	
	move_and_slide()
