extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if contact is made with the player, die
	if overlaps_body(get_parent().get_parent().get_node("Player")):
		get_parent().get_parent().get_node("Player").die()
