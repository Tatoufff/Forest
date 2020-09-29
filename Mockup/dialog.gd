extends Node

class_name Dialog

var txt = ""
var source_file = ""
var data = {}


func load_text_file(path):
	var f = File.new()
	var err = f.open(path, File.READ)
	if err != OK:
		printerr("Could not open file, error code ", err)
		return ""
	var text = f.get_as_text()
	f.close()
	return text
	
func _init(source, dialog_name) :
	source_file = source
	txt = load_text_file(source)
	parse_data()
	print(data)

func full_dialog() :
	print(txt)

func get_entry(n) :
	return data[n]

func get_choices(n) :
	var choices = []
	for line in get_entry(n) :
		if line.substr(0,1) == "<" :
			print(line)
			choices.append(line)
	return choices
	
func get_line(n,l) :
	return data[n][l]

func parse_data() :
	var lines = txt.split("\n")
	var entry = []
	var e = -1
	for line in lines :
		#print(line.substr(0,2))
		if line.substr(0,1) == "#" :
			if len(entry) > 0 and e != -1 :
				data[e] = entry
			entry = []
			e = int(line.substr(1,2))
			print("Scanning entry #"+str(e))
		else :
			entry.append(line.replace("\t", ""))
	data[e] = entry
