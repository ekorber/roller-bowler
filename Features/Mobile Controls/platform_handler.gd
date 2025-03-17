extends Node

var is_mobile: bool

func _ready() -> void:
	is_mobile = OS.has_feature('mobile') or OS.has_feature('web_android') or OS.has_feature('web_ios')
