extends GutTest

var scene = preload('res://Gameplay.tscn')

func test_pad():
	var scene_instance = scene.instance()
	add_child(scene_instance)
