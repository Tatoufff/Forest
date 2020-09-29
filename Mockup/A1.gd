extends Label

var base_color = Color("634d37")
var mouseover_color = Color("9f6c39")

var click_receiver


#9f6c39 and 634d37
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		var mouse_pos = event.position
		var self_pos = get_position()
		var self_size = get_combined_minimum_size()
		#print("Mouse pos", mouse_pos, "Self pos", self_pos, "self_size", self_size, "name", get_name())
		if mouse_pos.x > self_pos.x and mouse_pos.x < self_pos.x+self_size.x :
			if mouse_pos.y > self_pos.y and mouse_pos.y < self_pos.y+self_size.y :
				print(get_name()+" clicked !")
				on_click()

func on_click() :
	click_receiver.answer_click(get_name())

func register_as_click_receiver(obj) :
	click_receiver = obj
	print("Registered for "+get_name())
