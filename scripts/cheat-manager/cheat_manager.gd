extends Node
class_name CheatManager

# written by: Austingibb w/ ChatGPT o3-mini-high
# date: 2025-03-07
# description: A CheatManager singleton that listens for key inputs to activate cheats.
# notes: _fn denotes pure functions, otherwise methods may have a side effect.
# 		an underscore prefix for a method represents a private function that should only be used internally.

enum CheatInputState {
	HIDDEN,	# Beginning state, without modifier key pressed.
	VALID_PREFIX, # Sequence so far is valid, but doesn't match any configured cheats.
	EXACT_AMBIGUOUS, # Sequence matches an exact cheat, but it can be continued.
	EXACT_UNAMBIGUOUS, # Sequence matches an exact cheat, but it cannot be continued (terminal point for arrow keys entered)
	INVALID # Sequence entered doesn't match any configured cheats.
}

enum EventType {
	MODIFIER_PRESS,
	ARROW,
	SUBMIT,
	MODIFIER_RELEASE
}

signal cheat_state_changed(new_state: int)
signal cheat_activated(action: String)

var current_state: CheatInputState = CheatInputState.HIDDEN
var current_sequence: String = ""
var cheat_config: Dictionary = {}

# Customizable key mappings.
var modifier_key: Key = KEY_SHIFT
var submit_key: Key = KEY_ENTER

func _ready() -> void:
	load_config()
	get_tree().connect("tree_changed", Callable(self, "_on_tree_changed"))
#	print("CheatManager ready.")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == modifier_key:
				# Modifier key pressed.
				var result: Dictionary = transition_fn(event, EventType.MODIFIER_PRESS, current_state, current_sequence)
				update_state(result)
			elif current_state != CheatInputState.HIDDEN:
				if event.keycode in [KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT]:
					# Arrow key pressed.
					var result: Dictionary = transition_fn(event, EventType.ARROW, current_state, current_sequence)
					update_state(result)
				elif event.keycode == submit_key:
					# Submit key pressed.
					if current_state == CheatInputState.EXACT_UNAMBIGUOUS or\
					 current_state == CheatInputState.EXACT_AMBIGUOUS:
						var action: String = cheat_config["cheats"].get(current_sequence)
						if action != null:
							emit_signal("cheat_activated", action)

					var result: Dictionary = transition_fn(null, EventType.SUBMIT, current_state, current_sequence)
					update_state(result)
		else:
			if event.keycode == modifier_key:
				# Modifier key released.
				var result: Dictionary = transition_fn(null, EventType.MODIFIER_RELEASE, current_state, current_sequence)
				if current_state == CheatInputState.EXACT_UNAMBIGUOUS or\
					current_state == CheatInputState.EXACT_AMBIGUOUS:
					var action: String = cheat_config["cheats"].get(current_sequence)
					if action != null:
						emit_signal("cheat_activated", action)
				update_state(result)

# Transition function: takes an event, event_type, current state and sequence,
# and returns a dictionary with the updated state and sequence.
func transition_fn(event: InputEvent, event_type: CheatManager.EventType, state: CheatInputState, sequence: String) -> Dictionary:
	var new_state: CheatInputState = state
	var new_sequence: String = sequence

#	print("Transition function called with:")
#	print("  Event Type:", event_type)
#	print("  Current State:", state)
#	print("  Current Sequence:", sequence)

	if event_type == EventType.MODIFIER_PRESS:
#		print("  -> Modifier key pressed")
		if state == CheatInputState.HIDDEN:
#			print("  -> Transitioning to VALID_PREFIX state")
			new_state = CheatInputState.VALID_PREFIX
			new_sequence = ""
	elif event_type == EventType.ARROW:
		var arrow: String = _arrow_from_event(event)
		if arrow != "":
#			print("  -> Arrow key pressed:", arrow)
			new_sequence += arrow
#			print("  -> Updated sequence:", new_sequence)
			# Determine new state by comparing new_sequence against config.
			var has_exact: bool = false
			var has_extension: bool = false
			var cheats: Variant = cheat_config.get("cheats", {})
			for cheat_seq: String in cheats.keys():
				if cheat_seq == new_sequence:
					has_exact = true
				elif cheat_seq.begins_with(new_sequence):
					has_extension = true
			
#			print("  -> Cheat sequence analysis:")
#			print("     Exact match found:", has_exact)
#			print("     Possible extension:", has_extension)

			if has_exact:
				if has_extension:
#					print("  -> Sequence is an exact match but also has valid candidates for continued input, transitioning to EXACT_AMBIGUOUS")
					new_state = CheatInputState.EXACT_AMBIGUOUS
				else:
#					print("  -> Sequence is an exact match with no candidates for continued input, transitioning to EXACT_UNAMBIGUOUS")
					new_state = CheatInputState.EXACT_UNAMBIGUOUS
			elif has_extension:
				new_state = CheatInputState.VALID_PREFIX
#				print("  -> Sequence is a valid prefix of a longer cheat code, staying in VALID_PREFIX state")
			else:
				new_state = CheatInputState.INVALID
#				print("  -> Sequence does not match any configured cheat codes, transitioning to INVALID state")
	elif event_type == EventType.SUBMIT:
#		print("  -> Submit key pressed, executing cheat (if valid)")
		new_state = CheatInputState.HIDDEN
		new_sequence = ""
	elif event_type == EventType.MODIFIER_RELEASE:
#		print("  -> Reset event, clearing sequence and returning to hidden")
		new_state = CheatInputState.HIDDEN
		new_sequence = ""
	return { "state": new_state, "sequence": new_sequence }

# Helper to update the instance's state and emit signal.
# This function handles the exact output of the transition function.
func update_state(result: Dictionary) -> void:
	current_state = result["state"]
	current_sequence = result["sequence"]
	emit_signal("cheat_state_changed", current_state)

func load_config() -> void:
	cheat_config = _load_config_fn()

func _load_config_fn() -> Dictionary:
	# Hardcoded configuration for testing.
	var config: Dictionary = {
		"actions": {
			"change-ball-color": null,
			"change-ball-color-red": null,
			"save-game": null,
			"open-secret-door": null,
			"switch-active-char": null
		},
		"cheats": {
			"←↑→↓": "change-ball-color",
			"←↑→↓→": "change-ball-color-red",
			"←↑↑": "save-game",
			"↑→↑": "open-secret-door",
			"↑↑↑": "switch-active-char"
		}
	}
#	print("Cheat configuration loaded.")
	return config

func _arrow_from_event(event: InputEventKey) -> String:
	match event.keycode:
		KEY_UP: return "↑"
		KEY_DOWN: return "↓"
		KEY_LEFT: return "←"
		KEY_RIGHT: return "→"
		_: return ""

func _on_tree_changed() -> void:
	# Reset state on scene change.
	var result: Dictionary = transition_fn(null, EventType.MODIFIER_RELEASE, current_state, current_sequence)
	update_state(result)
	pass
