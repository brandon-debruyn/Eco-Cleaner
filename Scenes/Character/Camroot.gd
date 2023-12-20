extends Node3D

@export var mouse_sensitivity:float = 0.25
@export var mouse_accel:float = 10.0
@export var cam_vertical_min:int = 75
@export var cam_horizontal_max:int = -35

var camrot_h:float = 0
var camrot_v:float = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * mouse_sensitivity
		camrot_v += event.relative.y * mouse_sensitivity
		
func _physics_process(delta):
	camrot_v = clamp(camrot_v, cam_horizontal_max, cam_vertical_min)
	
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camrot_h, delta * mouse_accel)
	$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camrot_v, delta * mouse_accel)

