extends Node2D

var locations

func register_locations() :
	locations = []
	var location_root = get_node("Locations")
	for child in location_root.get_children() :
		locations.append(child)
		child.register_click_collector(self)

func location_clicked(name) :
	print("Clicked : "+ name)

func _ready():
	register_locations()
