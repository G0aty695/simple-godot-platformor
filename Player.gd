extends KinematicBody


var velocity_x = 0
var velocity_y = 0
var velocity_z = 0
var gravity = 0
var speed = 7
var facing = "left"
var touching_ground
var touching_left_wall
var touching_right_wall
var touching_any_wall
var touching_roof
var jump_stage
var jumping
var wall_jumping
var wall_jump_stage = 0
var dashing = false
var dash_timer = 5
var wall_jump_direction

func die():
	translation = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# reset all timers
	if dash_timer == 0:
		dash_timer = 5
		dashing = false
		
	# Sets up contact boloons
	if touching_left_wall or touching_right_wall:
		touching_any_wall = true
	else:
		touching_any_wall = false
		
	if $"Ground collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_ground = true
	else:
		touching_ground = false
	if $"left wall collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_left_wall = true
	else:
		touching_left_wall = false
	if $"right wall collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_right_wall = true
	else:
		touching_right_wall = false
	if $"roof collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_roof = true
	else:
		touching_roof = false
		
	# Add gravity
	if not touching_ground:
		if not touching_any_wall:
			gravity -= 0.4
		else:
			gravity -= 0.03
		velocity_y = gravity
	else:
		gravity = 0
		velocity_y = 0
	
	# Inputs
	if Input.is_action_pressed("left"):
		velocity_x -= speed
		facing = "left"
	if Input.is_action_pressed("right"):
		velocity_x += speed
		facing = "right"
	if Input.is_action_just_pressed("jump") and touching_ground:
		jumping = true
	if Input.is_action_just_pressed("jump") and not touching_ground and touching_any_wall:
		
		wall_jumping = true
		if touching_left_wall:
			wall_jump_direction = "right"
		if touching_right_wall:
			wall_jump_direction = "left"
		jumping = true
	if Input.is_action_pressed("dash") and dashing == false:
		dashing = true
		
	
	if dashing:
		dash_timer -= 1
		if facing == "left":
			velocity_x = 0 -speed * 3
		else:
			velocity_x = speed * 3
	if jumping:
		jump_stage += 1
		for i in range(20):
			if jump_stage == i:
				velocity_y = 60 / i
		
	if jump_stage == 20 or not Input.is_action_pressed("jump"):
		jump_stage = 0
		jumping = false
		
	if wall_jumping:
		wall_jump_stage += 1
		if wall_jump_direction == "left":
			velocity_x -= 3
		if wall_jump_direction == "right":
			velocity_x += 3
	if wall_jump_stage == 20 or not touching_any_wall:
		wall_jump_stage = 0
		wall_jumping = false
	
	
	
	move_and_slide(Vector3(velocity_x, velocity_y, velocity_z))
	velocity_x = 0
	velocity_y = 0
	velocity_z = 0
	print(wall_jump_stage)
	

