extends RigidBody3D

var is_being_collected = false
var collection_point: Vector3

@onready var audio_player = $AudioStreamPlayer3D if has_node("AudioStreamPlayer3D") else null

func _ready():
	add_to_group("litter_polution")

func start_collection(target_position: Vector3):
	is_being_collected = true
	collection_point = target_position
	set_as_top_level(true)

func _process(delta: float):
	if is_being_collected:
		var direction = (collection_point - global_transform.origin).normalized()
		global_transform.origin += direction * delta * 5  
		if global_transform.origin.distance_to(collection_point) < 1.0:  
			play_collection_sound()
			queue_free()

func play_collection_sound():
	if audio_player:
		audio_player.play()
