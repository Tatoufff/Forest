extends Node2D

var speed = 0
var current_follow
var pin

var i = 0

var locations
var roads = {}
var current_location
var next_location


func _ready():
	pin = get_node("Pin")
	initialize_roads()
	register_locations()
	
	current_location = "L1"
	current_follow = get_node("P1/F1")
	
func register_locations() :
	locations = []
	var location_root = get_node("Locations")
	for child in location_root.get_children() :
		locations.append(child)
		child.register_click_collector(self)

func location_clicked(name) :
	print("Clicked : "+ name)
	
	var road = get_road(current_location, name)[0]
	var reverse = get_road(current_location, name)[1]
	
	if road != null :
		follow(get_node("Roads/"+road), reverse)
		print("Following "+road)

func follow(path, reverse=false) :
	current_follow = path
	if reverse :
		current_follow.set_unit_offset(1)
		speed = -2
	else : 
		current_follow.set_unit_offset(0)
		speed = 2
	current_follow.set_loop(false)

func is_arrived() :
	if speed == 0 : 
		return false
	if speed > 0 :
		return current_follow.get_unit_offset() == 1
	if speed < 0 :
		return current_follow.get_unit_offset() == 0

func arrived() :
	speed = 0
	current_location = next_location
	print("Done !")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	current_follow.offset += speed
	pin.position.x = current_follow.position.x
	pin.position.y = current_follow.position.y
	
	if is_arrived() :
		arrived()

func get_road(current, next) :
	if current+"-"+next in roads :
		return [current+"-"+next, false]
	elif next+"-"+current in roads :
		return [next+"-"+current, true]
	else :
		return null

func initialize_roads() :
	var raw_roads = get_node("Roads").get_children()
	roads = []
	for r in raw_roads :
		roads.append(r.get_name())

