extends Node3D

# Export variables to adjust from the editor
@export var num_pollution_items: int = 10
#@export var pollution_item_scenes: Array = [
#	preload("res://Scenes/Environment/pollution/litter/garbage_bag.tscn"),
#	preload("res://Scenes/Environment/pollution/litter/plastic_bottle.tscn"),
#	preload("res://Scenes/Environment/pollution/litter/soda_can.tscn"),
#	preload("res://Scenes/Environment/pollution/litter/wine_bottle.tscn"),
#	preload("res://Scenes/Environment/pollution/litter/cigarette_pack.tscn")
#]

# Exported variables with default values as placeholders
@export var min_x: float = 0
@export var max_x: float = 0
@export var min_z: float = 0
@export var max_z: float = 0
@export var y_height: float = 0.5

@onready var map_node = $Node3D

func _ready():
	#randomize()
	#spawn_pollution_items()
	pass

#func spawn_pollution_items():
#	var pollution_areas = get_tree().get_nodes_in_group("pollution_area")  
#
#	for area in pollution_areas:
#		for i in range(num_pollution_items):
#			var item_scene = pollution_item_scenes[randi() % pollution_item_scenes.size()]
#			if item_scene == null or not item_scene is PackedScene:
#				printerr("Invalid item scene:", item_scene)
#				continue
#
#			var item_instance = item_scene.instantiate()
#
#			var area_bounds = area.get_aabb()
#			var random_position = area.global_transform.origin + Vector3(
#				randf_range(-area_bounds.size.x / 2, area_bounds.size.x / 2),
#				0,  
#				randf_range(-area_bounds.size.z / 2, area_bounds.size.z / 2))
#
#			item_instance.global_transform.origin = random_position
#			add_child(item_instance)
