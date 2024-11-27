extends CharacterBody3D


var target_position = Vector3.ZERO
var list_of_target_positions = []

@export var speed = 3
@export var speed_multiplier = 2

@export var position_1: Node
@export var position_2: Node
@export var position_3: Node
@export var position_4: Node

@onready var run_particles: GPUParticles3D = $RunParticles
@onready var nav: NavigationAgent3D = $NavigationAgent3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var in_panic = false


func _ready():
	list_of_target_positions = get_node("../TargetPositions").get_children()
	set_new_target_position()


func _process(delta):
	var direction = Vector3()
	var total_speed = speed
	
	if in_panic:
		run_particles.emitting = true
		total_speed *= speed_multiplier
	else:
		run_particles.emitting = false
	
	nav.target_position = target_position.global_position
	
	direction = nav.get_next_path_position() - global_position
	direction.y = 0
	direction = direction.normalized()
	
	velocity = direction * total_speed
	velocity.y -= gravity * delta
	
	var look_direction = -Vector2(velocity.z, velocity.x)
	$Villager.rotation.y = look_direction.angle()
	
	if nav.is_navigation_finished():
		in_panic = false
		set_new_target_position()

	velocity.y -= gravity * delta
	move_and_slide()


func set_new_target_position():
	randomize()
	target_position = list_of_target_positions.pick_random()


func start_panic(furry_position):
	if furry_position.x > global_position.x:
		if furry_position.z < global_position.z:
			target_position = position_3
		else:
			target_position = position_1
	else:
		if furry_position.z < global_position.z:
			target_position = position_4
		else:
			target_position = position_2
	
	in_panic = true
