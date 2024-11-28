extends Control

@onready var convince_label: Label = $ConvinceLabel


func update_convince_label(value):
	if value == true:
		convince_label.visible = true
	else:
		convince_label.visible = false
