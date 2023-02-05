extends KinematicBody2D

signal health_updated(health)
signal killed()

const GRAVITY := 18.0
const MOVE_ACCEL := 10.0 # Movement acceleration.
const FRIC_MOD := 0.4 # Friction modifier.
const MAX_MOVE_SPEED := 180.0
const JUMP_SPEED := 350.0
const DOUBLE_JUMP_SPEED := 280.0

export var max_health = 100

onready var health = max_health setget _set_health
onready var invulnerability_timer = get_node("/root/Node2D/InvulnerabilityTimer")

var _velocity := Vector2()
var double_jump = false
var touching = false

func _physics_process(_delta):
	
	if touching == true:
		_damage(10)
	
	_velocity.y += GRAVITY # Apply gravity
	
	var input = (Input.get_action_strength("ui_right") - 
		Input.get_action_strength("ui_left")) 
	
	# If there was input and it didn't cancel itself out.
	if input != 0: 
		_velocity.x += input * MOVE_ACCEL # Accelerates in the movement direction.
		
		$Area2D/AnimatedSprite.play("walk")
		$Area2D/AnimatedSprite.flip_h = input < 0
	else:
		$Area2D/AnimatedSprite.play("idle")
		_velocity.x *= FRIC_MOD # Applies friction.
	
	# Clamps the movement speed to a max value.
	_velocity.x = clamp(_velocity.x, -MAX_MOVE_SPEED, MAX_MOVE_SPEED) 
	
	# If on the floor and the jump button is pressed, apply the jump speed.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			double_jump = false
			_velocity.y = -JUMP_SPEED
			double_jump = true
	
	if !is_on_floor() and double_jump == true:
		if Input.is_action_just_pressed("ui_jump"):
			_velocity.y = -DOUBLE_JUMP_SPEED
			double_jump = false
			
	# Moves the character by the velocity.
	_velocity = move_and_slide(_velocity, Vector2.UP)

func _damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)

func _kill():
	print("dead")
	if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the player game screen scene")

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		$Area2D/AnimatedSprite/ProgressBar1.value = health
		print("Prev Health ",prev_health)
		if health == 0:
			_kill()
			emit_signal("killed")

func _on_Area2D_area_entered(_area):
	touching = true

func _on_Area2D_area_exited(_area):
	touching = false
