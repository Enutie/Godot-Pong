extends AudioStreamPlayer

var aw_sound = preload("res://assets/sounds/aaaw.ogg")
var bing_sound = preload("res://assets/sounds/bing.ogg")
var boing_sound = preload("res://assets/sounds/boing.ogg")
var bop_sound = preload("res://assets/sounds/bop.ogg")
var ping_sound = preload("res://assets/sounds/ping.ogg")
var yay_sound = preload("res://assets/sounds/yay.ogg")

var audio_node = null

func ready():
	audio_node = self
	audio_node.connect("finished", self, "destroy_self")
	audio_node.stop()
	
func play_sound(sound_name, position=null):
	
	if aw_sound == null or bing_sound == null or boing_sound == null or bop_sound == null or ping_sound == null or yay_sound:
		print("Audio not set!")
		queue_free()
		return
		
	if sound_name == "aw_sound":
		audio_node.stream = aw_sound
	elif sound_name == "bing_sound":
		audio_node.steam == bing_sound
	elif sound_name == "boing_sound":
		audio_node.steam == boing_sound
	elif sound_name == "bop_sound":
		audio_node.steam == bop_sound
	elif sound_name == "ping_sound":
		audio_node.steam == ping_sound
	elif sound_name == "yay_sound":
		audio_node.steam == yay_sound
		
	audio_node.play()
	
func destroy_self():
	audio_node.stop()
	queue_free()
