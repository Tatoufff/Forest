extends Area2D

var click_collector

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	click_collector.location_clicked(get_name())

func register_click_collector(click_col) :
	#print("Click collector connected : "+click_col.get_name()+" <-> "+get_name())
	click_collector = click_col
	
