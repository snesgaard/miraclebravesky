tool
extends AnimationPlayer

export(Array, String, FILE) var jsons setget update_json
export(bool) var refresh setget on_reset


func get_image_path(json_path, data):
	if not data['meta']['image']:
		print("Image path not supplied")
		return
	else:
		return "%s/%s" % [json_path.get_base_dir(), data['meta']['image']]

func get_json_animation(name):
	if not has_animation(name):
		var animation = Animation.new()
		add_animation(name, animation)
	
	return get_animation(name)

func track_texture_track(animation, image_path):
	var path = "Sprite:texture"
	var i = animation.find_track(path)
	if i < 0:
		i = animation.add_track(Animation.TYPE_VALUE)
		animation.track_set_path(i, path) 
		animation.track_set_enabled(i, true)
	var tex = load(image_path)
	animation.track_insert_key(i, 0, tex)

func get_clear_track_index(animation, path):
	var i = animation.find_track(path)
	if i > 0:
		animation.remove_track(i)
	i = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(i, path) 
	animation.track_set_enabled(i, true)
	animation.value_track_set_update_mode(i, Animation.UPDATE_DISCRETE)
	return i
	

func track_roi_offset(animation, data, from, to, origin):
	get_clear_track_index(animation, "Sprite:region_rect")
	get_clear_track_index(animation, "Sprite:offset")

	var rect_index = animation.find_track("Sprite:region_rect")
	var off_index = animation.find_track("Sprite:offset")
	
	var t = 0
	var frames = data['frames']
	for j in range(from, to + 1):
		var f = frames[j]
		var frame = f['frame']
		var x = frame['x']
		var y = frame['y']
		var r = Rect2(x, y, frame['w'], frame['h'])
		var source = f['spriteSourceSize']
		var o = Vector2(source['x'], source['y']) - origin
		animation.track_insert_key(rect_index, t, r)
		animation.track_insert_key(off_index, t, o)
		t = t + f['duration'] / 1000.0
	
	return t


func search_origin_slice(slices):
	for s in slices:
		if s['name'] == 'origin':
			return s
	return


func origin_offset(slices):
	var origin_slice = search_origin_slice(slices)
	if not origin_slice:
		return Vector2(0, 0)
	
	var keys = origin_slice['keys']
	if len(keys) == 0:
		return Vector2(0, 0)
	var bounds = keys[0]['bounds']
	return Vector2(bounds['x'], bounds['y'] + bounds['h'])

func update_animation(path, sprite):
	var f = File.new()
	if(f.open(path, File.READ)):
		print("Could not read file: <%s>", path)
		return false
	
	var s = f.get_as_text()
	f.close()
	
	var parse_res = JSON.parse(s)
	
	if (parse_res.error):
		print("Error <%i> while parsing JSON <%s>", parse_res.error, path)
		return false
	
	var data = parse_res.result
	var im_path = get_image_path(path, data)
	var frames = data['frames']
	var meta = data['meta']
	var frame_tags = meta['frameTags']
	var slices = meta['slices']
	var origin = origin_offset(slices)
	
	if len(frame_tags) == 0:
		# Insert a tag, representing the full character animation
		frame_tags.append(
			{"name": "full", "from": 0, "to": len(frames) - 1, "direction": "forward"}
		)

	var name = path.get_file().get_basename()
	for t in frame_tags:
		var tag_name = name + "_" + t["name"]
		print("Adding animation ", tag_name)
		var animation = get_json_animation(tag_name)
		track_texture_track(animation, im_path)
		var d = track_roi_offset(animation, data, t["from"], t["to"], origin)
		animation.length = d
	
	
func update_all_animations(jsons):
	var sprite = get_node("../Sprite")
	if !sprite:
		print("Could not locate sprite")
		return 

	sprite.region_enabled = true
	for path in jsons:
		update_animation(path, sprite)

func _ready():
	print("hi")
	
func on_reset(new_value):
	update_all_animations(jsons)
	
func update_json(new_value):
	update_all_animations(new_value)
	jsons = new_value