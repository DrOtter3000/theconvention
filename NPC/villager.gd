extends CharacterBody3D

var speed = 4.9


var target_position = Vector3.ZERO
var list_of_target_positions = []

@onready var nav: NavigationAgent3D = $NavigationAgent3D

var in_line_of_sight : bool
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	randomize()
	list_of_target_positions = get_node("../TargetPositions").get_children()
	set_new_target_position()


func _process(delta):
	speed = 2
	var direction = Vector3()
			
	nav.target_position = target_position.global_position
	
	direction = nav.get_next_path_position() - global_position
	direction.y = 0
	direction = direction.normalized()
	
	velocity = direction * (speed)
	velocity.y -= gravity * delta
	
	var look_direction = -Vector2(velocity.z, velocity.x)
	$Villager.rotation.y = look_direction.angle()
	
	if nav.is_navigation_finished():
		set_new_target_position()

	velocity.y -= gravity * delta
	move_and_slide()


func set_new_target_position():
	target_position = list_of_target_positions.pick_random()
