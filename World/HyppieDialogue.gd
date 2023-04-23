extends Node2D

onready var text = $Label
onready var portrait = $AnimationPlayer

export var talkCD = 2
export var talktime = 5
onready var talkNow = 20
var talking = false

export var sentences = ["Meeec relax \non est cool", "Prend une cigarette pour \nte calmer, man","Ou encore mieux, \nun GROS PILON SA MERE","Wooooow","Je ferai bien un \npetit hawai du zanzi' perso","Un burger hawai vege","Avec des frites","Et un gros \nPILON SA MERE aussi"]
var index = 0

func _process(delta):
	if (OS.get_ticks_msec() > talkNow and !talking):
		talking = true
		talk()
	if (OS.get_ticks_msec() > talkNow+talktime*1000 and talking):
		text.text = ""
		talking = false
		talkNow = OS.get_ticks_msec() + talkCD*1000
	
	if talking:
		portrait.play("Talk")
	else:
		portrait.play("RESET")

func talk():
	text.text = sentences[index]
	index = (index+1)%len(sentences)
