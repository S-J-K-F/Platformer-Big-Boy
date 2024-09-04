extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -251.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var jump_max = 2
var jump_count = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	
	#reset jump
	if is_on_floor() and jump_count!=0:
		jump_count = 0
	
	if jump_count<jump_max:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			jump_count += 1

	# Get the input direction -1, 0, 1.
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
		#player animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idleing")
		else:
			animated_sprite.play("Running")
	else:
		animated_sprite.play("Jumping")
	
	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
