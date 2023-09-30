extends Node

var sounds = {
	"music":preload("res://sounds/fight_looped.wav"),
	"attach_part":preload("res://sounds/attach_part.wav"), 
	"explosion":preload("res://sounds/explosion.wav"), 
	"laser":preload("res://sounds/laser.wav"), 
	"hit":preload("res://sounds/hitHurt.wav"), 
	"p_hit":preload("res://sounds/playerHurt.wav"), 
	"shoot":preload("res://sounds/laserShoot.wav"), 
	"powerup":preload("res://sounds/powerUp.wav"), 
	"return":preload("res://sounds/return_to_game.wav")
}

var music_node = null

func _ready():
	music_node = AudioStreamPlayer.new()
	add_child(music_node)
	
	process_mode = PROCESS_MODE_ALWAYS
	_switch_music("music",-10)


func _switch_music(track_name, volume = -20):
	music_node.volume_db = volume
	music_node.stream = sounds[track_name]
	
	music_node.play()


func _play_sound(sound = "shing1", volume = 0,pitchvariance := 0.0):
	var soundinstance = AudioStreamPlayer.new()
	if sound is String:
		soundinstance.stream = sounds[sound]
	else:
		soundinstance.stream = sounds[sound.pick_random()]
	soundinstance.volume_db = volume
	soundinstance.pitch_scale = randf_range(-pitchvariance,pitchvariance) + 1
	var id = soundinstance.get_instance_id()
	soundinstance.connect("finished",Callable(self,"_sound_when_done").bind(id))
	add_child(soundinstance)
	soundinstance.play()


func _sound_when_done(objecttokill):
	instance_from_id(objecttokill).queue_free()
