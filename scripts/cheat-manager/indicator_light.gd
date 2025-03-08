extends ColorRect

func _on_cheat_manager_cheat_state_changed(new_state: int) -> void:
	var cheat_manager_state: CheatManager.CheatInputState = new_state as CheatManager.CheatInputState

	if cheat_manager_state == CheatManager.CheatInputState.HIDDEN:
		self.visible = false
	else:
		self.visible = true

	match cheat_manager_state:
		CheatManager.CheatInputState.HIDDEN:
			self.color = Color(1, 1, 1)  # White (but hidden)
		CheatManager.CheatInputState.VALID_PREFIX:
			self.color = Color(1, 0.5, 0)  # Orange
		CheatManager.CheatInputState.EXACT_AMBIGUOUS:
			self.color = Color(0, 0.5, 0)  # Dark Green
		CheatManager.CheatInputState.EXACT_UNAMBIGUOUS:
			self.color = Color(0, 1, 0)  # Light Green
		CheatManager.CheatInputState.INVALID:
			self.color = Color(1, 0, 0)  # Red
