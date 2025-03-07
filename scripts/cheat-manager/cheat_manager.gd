extends Node
class_name CheatManager

# written by: Austingibb w/ ChatGPT o3-mini-high
# date: 2025-03-07
# description: A CheatManager singleton that listens for key inputs to activate cheats.
# notes: _fn denotes pure functions, otherwise methods may have a side effect.
# 		an underscore prefix for a method represents a private function that should only be used internally.

enum CheatInputState {
	HIDDEN,
	VALID_PREFIX,
	EXACT_AMBIGUOUS,
	EXACT_UNAMBIGUOUS,
	INVALID
}

enum EventType {
	MODIFIER_PRESS,
	ARROW,
	SUBMIT,
	MODIFIER_RELEASE
}

signal cheat_state_changed(new_state : int)
signal cheat_activated(action : String)

var current_state : CheatInputState = CheatInputState.HIDDEN
var current_sequence : String = ""
var cheat_config : Dictionary = {}

# Customizable key mappings.
var modifier_key : Key = KEY_SHIFT
var submit_key : Key = KEY_ENTER

func _ready() -> void:
	load_config()
	get_tree().connect("tree_changed", Callable(self, "_on_tree_changed"))
	print("CheatManager ready.")

func _input(_event : InputEvent) -> void:
	#if event is InputEventKey:
	#	if event.pressed:
	#		if event.scancode == modifier_key:
	#			# Modifier key pressed.
	#			var result = transition(event, "modifier_press", current_state, current_sequence)
	#			update_state(result)
	#		elif current_state != CheatInputState.HIDDEN:
	#			if event.scancode in [KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT]:
	#				# Arrow key pressed.
	#				var result = transition(event, "arrow", current_state, current_sequence)
	#				update_state(result)
	#			elif event.scancode == submit_key:
	#				# Submit key pressed.
	#				if current_state == CheatInputState.EXACT_UNAMBIGUOUS:
	#					var action = cheat_config["cheats"].get(current_sequence, null)
	#					if action != null:
	#						emit_signal("cheat_activated", action)
	#				var result = transition(event, "submit", current_state, current_sequence)
	#				update_state(result)
	#	else:
	#		if event.scancode == modifier_key:
	#			# Modifier key released.
	#			var result = transition(event, "modifier_release", current_state, current_sequence)
	#			update_state(result)
	pass

# Transition function: takes an event, event_type, current state and sequence,
# and returns a dictionary with the updated state and sequence.
func transition_fn(event : InputEvent, event_type : CheatManager.EventType, state : CheatInputState, sequence : String) -> Dictionary:
	#var new_state = state
	#var new_sequence = sequence
	#if event_type == "modifier_press":
	#	if state == CheatInputState.HIDDEN:
	#		new_state = CheatInputState.VALID_PREFIX
	#		new_sequence = ""
	#elif event_type == "arrow":
	#	var arrow = _arrow_from_event(event)
	#	if arrow != "":
	#		new_sequence += arrow
	#		# Determine new state by comparing new_sequence against config.
	#		var has_exact = false
	#		var has_extension = false
	#		var cheats = cheat_config.get("cheats", {})
	#		for cheat_seq in cheats.keys():
	#			if cheat_seq == new_sequence:
	#				has_exact = true
	#			elif cheat_seq.begins_with(new_sequence):
	#				has_extension = true
	#		if new_sequence == "":
	#			new_state = CheatInputState.HIDDEN
	#		elif has_exact:
	#			if has_extension:
	#				new_state = CheatInputState.EXACT_AMBIGUOUS
	#			else:
	#				new_state = CheatInputState.EXACT_UNAMBIGUOUS
	#		elif has_extension:
	#			new_state = CheatInputState.VALID_PREFIX
	#		else:
	#			new_state = CheatInputState.INVALID
	#elif event_type == "submit":
	#	new_state = CheatInputState.HIDDEN
	#	new_sequence = ""
	#elif event_type == "modifier_release":
	#	new_state = CheatInputState.HIDDEN
	#	new_sequence = ""
	#return { "state": new_state, "sequence": new_sequence }
	return { "state": CheatInputState.HIDDEN, "sequence": "" }

# Helper to update the instance's state and emit signal.
# This function handles the exact output of the transition function.
func update_state(result : Dictionary) -> void:
	current_state = result["state"]
	current_sequence = result["sequence"]
	emit_signal("cheat_state_changed", current_state)

func load_config() -> void:
	cheat_config = _load_config_fn()

func _load_config_fn() -> Dictionary:
	# Hardcoded configuration for testing.
	var config : Dictionary = {
		"actions": {
			"change-ball-color": null,
			"change-ball-color-red": null,
			"save-game": null,
			"open-secret-door": null
		},
		"cheats": {
			"←↑→↓": "change-ball-color",
			"←↑→↓→": "change-ball-color-red",
			"←↑↑": "save-game",
			"↑→↑": "open-secret-door"
		}
	}
	print("Cheat configuration loaded.")
	return config

func _arrow_from_event(event : InputEvent) -> String:
	match event.scancode:
		KEY_UP: return "↑"
		KEY_DOWN: return "↓"
		KEY_LEFT: return "←"
		KEY_RIGHT: return "→"
		_: return ""

func _on_tree_changed() -> void:
	# Reset state on scene change.
	#var result = transition(null, "modifier_release", current_state, current_sequence)
	#update_state(result)
	pass
