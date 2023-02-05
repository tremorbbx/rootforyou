extends KinematicBody2D

#signal bat_health_updated(health)
#signal bat_killed()

var speed = 100
var touching = false
onready var obj = get_parent().get_node("Player")

export var bat_max_health = 100

onready var bat_health = bat_max_health setget _set_bat_health
onready var invulnerability_timer = get_node("/root/Node2D/BatDamageTimer")

func _physics_process(delta):
	
	if touching == true and Globals.damage_active:
		if Globals.basic_damage_active:
			_bat_damage(Globals.basic_damage)
		if Globals.heavy_damage_active:
			_bat_damage(Globals.heavy_damage)
	
	var dir = (obj.global_position - global_position).normalized()
	move_and_collide(dir * speed * delta)

func _bat_damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_bat_health(bat_health - amount)

func _kill():
	print("bat dead")
	queue_free()

func _set_bat_health(value):
	var bat_prev_health = bat_health
	bat_health = clamp(value, 0, bat_max_health)
	if bat_health != bat_prev_health:
		#emit_signal("health_updated", bat_health)
		$BatArea/AnimatedSprite/ProgressBar2.value = bat_health
		print("Prev Health ",bat_prev_health)
		if bat_health == 0:
			_kill()
			#emit_signal("killed")

func _on_BatArea_area_entered(area):
	if area.is_in_group("player"):
		touching = true

func _on_BatArea_area_exited(area):
	if area.is_in_group("player"):
		touching = false
		Globals.damage_active == false
