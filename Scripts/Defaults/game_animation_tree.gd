extends AnimationTree


func set_anim_player(animation_player_scene):
	var animation_player = animation_player_scene.instantiate()
	add_child(animation_player)
	set_animation_player(get_path_to(get_child(0)))
	active = true
