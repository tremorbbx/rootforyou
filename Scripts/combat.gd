extends AnimatedSprite

var touching = false

func _process(delta: float) -> void:
		
	look_at(get_global_mouse_position())
	if get_global_mouse_position() < get_node("/root/Node2D/Player/Area2D/PlayerSprite").position:
		get_node("/root/Node2D/Player/Area2D/PlayerSprite").flip_h = 1
	if get_global_mouse_position() > get_node("/root/Node2D/Player/Area2D/PlayerSprite").position:
		get_node("/root/Node2D/Player/Area2D/PlayerSprite").flip_h = 0

	if Input.is_action_just_pressed("ui_left_click"):
		Globals.damage_active = true
		Globals.basic_damage_active = true
		get_node("/root/Node2D/Player/Area2D/PlayerSprite/WandSprite").play("attack")
	if get_node("/root/Node2D/Player/Area2D/PlayerSprite/WandSprite").frame == 13:
		get_node("/root/Node2D/Player/Area2D/PlayerSprite/WandSprite").stop()
		get_node("/root/Node2D/Player/Area2D/PlayerSprite/WandSprite").frame = 0
		Globals.damage_active = false
		Globals.basic_damage_active = false
	
	if Input.is_action_just_pressed("ui_right_click"):
		get_node("/root/Node2D/AnimatedSprite").global_position = get_global_mouse_position()
		#get_node("/root/Node2D/AnimatedSprite").global_position.y = 563
		Globals.damage_active = true
		Globals.heavy_damage_active = true
		get_node("/root/Node2D/AnimatedSprite/RootArea/CollisionShape2D").disabled = false
		get_node("/root/Node2D/AnimatedSprite").visible = true
		get_node("/root/Node2D/AnimatedSprite").play("attack")
		
	if get_node("/root/Node2D/AnimatedSprite").frame == 18:
		get_node("/root/Node2D/AnimatedSprite").stop()
		get_node("/root/Node2D/AnimatedSprite").visible = false
		get_node("/root/Node2D/AnimatedSprite/RootArea/CollisionShape2D").disabled = true
		get_node("/root/Node2D/AnimatedSprite").frame = 0
		Globals.damage_active = false
		Globals.basic_damage_active = false
