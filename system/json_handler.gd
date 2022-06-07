extends Node
	
func to_json_string(dict: Dictionary): return "'%s'" % JSON.print(dict)
func load_json_from_browser(loaded_values): return JSON.parse(loaded_values).result
func load_json_from_file(path: String) -> Dictionary:
	var file = File.new()
	assert(file.file_exists(path), "File path does not exist.")
	file.open(path, File.READ)
	var json = file.get_as_text()
	var output = parse_json(json)
	return output
