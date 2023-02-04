extends KinematicBody2D

const GRAVITY := 20.0
const MOVE_ACCEL := 10.0 # Movement acceleration.
const FRIC_MOD := 0.4 # Friction modifier.
const MAX_MOVE_SPEED := 300.0
const JUMP_SPEED := 450.0

var _velocity := Vector2()

func _physics_process(_delta):
	_velocity.y += GRAVITY # Apply gravity
	
	var input = (Input.get_action_strength("ui_right") - 
		Input.get_action_strength("ui_left")) 
	
	# If there was input and it didn't cancel itself out.
	if input != 0: 
		_velocity.x += input * MOVE_ACCEL # Accelerates in the movement direction.
		$CollisionShape2D/AnimatedSprite.flip_h = input < 0
	else:
		_velocity.x *= FRIC_MOD # Applies friction.
	
	# Clamps the movement speed to a max value.
	_velocity.x = clamp(_velocity.x, -MAX_MOVE_SPEED, MAX_MOVE_SPEED) 
	
	# If on the floor and the jump button is pressed, apply the jump speed.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			_velocity.y = -JUMP_SPEED
	
	# Moves the character by the velocity.
	_velocity = move_and_slide(_velocity, Vector2.UP)
