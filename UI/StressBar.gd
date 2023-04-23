extends TextureProgress

var previous_kill_count = 0

func _process(delta):
	if GameManager.GAME_STARTED: self.visible = true
	else: self.visible = false
	
	GameManager.RAGE += (GameManager.NPC_KILL_COUNT - previous_kill_count)*GameManager.GET_RAGE_PER_KILL()
	previous_kill_count = GameManager.NPC_KILL_COUNT
	
	#GameManager.RAGE  -= 100 * delta
	# Don't go below zero
	GameManager.RAGE  = max(GameManager.RAGE , 0)
	
	# Assuming this is a node you have set up
	self.value = GameManager.RAGE 
