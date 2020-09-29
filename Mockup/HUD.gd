extends Node2D



var Dialog = load("res://dialog.gd")
var text_field
var current_dialog
var current_entry
var current_line
var answers

# Called when the node enters the scene tree for the first time.
func _ready():
	current_dialog = Dialog.new("dialog.txt", "Intro1")
	#print(entry)
	text_field = get_node("/root/Main/HUD/HUD/Text")
	current_entry = 1
	current_line = 0
	var entry = current_dialog.get_entry(1)
	display_text(entry[0])
	
	answers = [get_node("/root/Main/HUD/HUD/QnA/A1"), get_node("/root/Main/HUD/HUD/QnA/A2"), get_node("/root/Main/HUD/HUD/QnA/A3")]
	for a in answers : 
		a.register_as_click_receiver(self)
		a.visible = false

func get_current_line() :
	return current_dialog.get_line(current_entry,current_line)

func go_to_entry(n) :
	current_entry = n
	current_line = 0
	var line = get_current_line()
	if line.substr(0,1) == "<" :
		display_choice(n)
	else :
		display_text(get_current_line())

func display_choice(n) :
	var choices = current_dialog.get_choices(n)
	
	text_field.visible = false
	var i=0
	for a in answers :
		a.visible = true
		if i<len(choices) :
			a.text = choices[i]
		else :
			a.text = ""
		i+=1

func next_line() :
	current_line += 1
	var txt = get_current_line()
	if txt.substr(0,1) == '#' :
		if txt == "#END" :
			get_tree().quit()
		else : 
			var n = int(txt.replace("#", ""))
			go_to_entry(n)
	else :
		display_text(txt)

func display_text(txt) :
	print("Displaying : '"+txt+"'")
	text_field.text = txt

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			next_line()

func answer_click(name) :
	print("Received click for "+name)
	var choices = current_dialog.get_choices(current_entry)
	var n = int(name.substr(1,2))-1
	
	var valid_choice = choices[n]
	var i=0
	var entry = current_dialog.get_entry(current_entry)
	for line in entry :
		if line == valid_choice :
			current_line = i
		i+=1
	
	text_field.visible = true
	for a in answers : 
		a.visible = false
	next_line()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
