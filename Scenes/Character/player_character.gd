extends CharacterBody3D

@onready var camera = $Camroot/h/v/Camera3D
@onready var animation_player = $"3DGodotRobot/AnimationPlayer"

@export var speed:float = 2.0
@export var jump_velocity:float = 20.0
@export var rot_speed: float = 5.0
@export var gravity:float = 9.8

var camera_rotation: Vector2 = Vector2.ZERO
var is_jumping: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Area3D.connect("body_entered", Callable(self, "_on_body_entered"))
	if Engine.is_editor_hint():
		$CollisionShape3D.visible = true
	else:
		$CollisionShape3D.visible = false

func _physics_process(delta):
	var input_dir = Input.get_vector("move_right", "move_left", "move_forward", "move_backward")
	var moving = input_dir.length() > 0
	
	if Input.is_action_pressed("ui_right_click") and camera:
		# Rotate the player to face the same direction as the camera
		var cam_direction = camera.global_transform.basis.z.normalized()
		var forward_direction = Vector3(-cam_direction.x, 0, -cam_direction.z)
		var right_direction = camera.global_transform.basis.x.normalized()
		var target_rotation = atan2(forward_direction.x, forward_direction.z)

		rotation.y = lerp_angle(rotation.y, target_rotation, rot_speed * delta)

		# Calculate the movement direction relative to the camera's orientation
		var direction = forward_direction * input_dir.y + right_direction * input_dir.x
		direction.y = 0
		
		# Apply movement
		velocity = direction * speed
	else:
		# Normal movement without camera direction
		var direction = transform.basis.z.normalized() * -input_dir.y
		direction += transform.basis.x.normalized() * input_dir.x
		direction.y = 0
		velocity = direction * speed
			
	# Apply gravity
	velocity.y -= 10 * gravity * delta

	# Handle Jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
		is_jumping = true

	# Apply gravity
	if not is_on_floor() or is_jumping:
		velocity.y += gravity * delta

	# Reset is_jumping flag when on floor
	if is_on_floor():
		is_jumping = false

	# Move and slide
	move_and_slide()

	if moving:
		if animation_player.current_animation != "Run":
			animation_player.play("Run")
	else:
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")

func _on_body_entered(body):
	print("Collided with:", body.name)
	print(body.get_groups())
	print(body.is_in_group("litter_polution"))
	if body.is_in_group("litter_polution"):  
		body.start_collection(global_transform.origin) 


