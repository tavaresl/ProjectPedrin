extends TextureButton

var this : TextureButton = self
var dragging : bool = false
var originalPosition : Vector2

#func _process(delta):
#	if dragging:
#		var viewportCursorPosition : Vector2 = get_viewport().get_mouse_position()
#		viewportCursorPosition.x -= (this.size.x/2) + (get_viewport().size.x/2)
#		viewportCursorPosition.y -= (this.size.y/2) + (get_viewport().size.y/2)
#		self.global_position = viewportCursorPosition

#func drag():
#	print("Clicked on Card")
#	originalPosition = self.global_position
#	dragging = true

#func drop():
#	print("Released out of Card")
#	dragging = false
#	self.global_position = originalPosition


func _on_pressed():
	print("Clicked on a Card")
	pass
