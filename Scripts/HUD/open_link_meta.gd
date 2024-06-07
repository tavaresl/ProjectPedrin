extends RichTextLabel

@onready var this : RichTextLabel = self

func _ready() -> void:
	this.meta_clicked.connect(open_href)

func open_href(meta):
	OS.shell_open(meta)
