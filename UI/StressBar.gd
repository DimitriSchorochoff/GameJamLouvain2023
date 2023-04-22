extends TextureProgress

const BAR_SPEED = 100
var current_bar_value = 500
var previous_kill_count = 0

func _process(delta):
	current_bar_value += (GameManager.NPC_KILL_COUNT - previous_kill_count)*BAR_SPEED
	previous_kill_count = GameManager.NPC_KILL_COUNT
	
	#scurrent_bar_value -= BAR_SPEED * delta
	# Don't go below zero
	current_bar_value = max(current_bar_value, 0)
	
	# Assuming this is a node you have set up
	self.value = current_bar_value
