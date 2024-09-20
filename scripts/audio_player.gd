extends AudioStreamPlayer

const level_music = preload("res://assets/sounds/music/sb_indreams(chosic.com).mp3")

func _play_music(music: AudioStream, volume = -25.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	
	play()
	
func play_music():
	_play_music(level_music)
	
	
func play_FX(stream: AudioStream, volumn = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volumn
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()
