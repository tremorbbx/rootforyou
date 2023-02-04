extends KinematicBody2D

var speed = 100
var direction
onready var target = get_parent().get_node("Player")
var motion = Vector2()

#func _physics_process(delta):
#	if target.position.x < position.x:
#		direction.x = -1
#	if target.position.x > position.x:
#		direction.x = 1
#
#	move_and_collide(direction * speed)
