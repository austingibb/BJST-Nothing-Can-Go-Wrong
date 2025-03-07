extends Node
class_name CheatManagerTest

# written by: Austingibb w/ ChatGPT o3-mini-high
# date: 2025-03-07
# description: Tests cheat manager transitions.
# notes: This is currently unverified to be adequate tests, I need to put more time in. As of right now this is 90% ChatGPT o3-mini-high generated code.

# Helper function to create a fake InputEventKey.
static func create_fake_key_event(keycode: Key) -> InputEventKey:
	var event : InputEventKey = InputEventKey.new()
	event.keycode = keycode
	event.pressed = true
	return event

func test_modifier_press() -> void:
	var cm : CheatManager = CheatManager.new()
	cm.load_config()
	# Simulate modifier press when hidden.
	var fake_event : InputEventKey = CheatManagerTest.create_fake_key_event(cm.modifier_key)
	var result : Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.MODIFIER_PRESS, CheatManager.CheatInputState.HIDDEN, "")
	assert(result["state"] == CheatManager.CheatInputState.VALID_PREFIX, "Modifier press test: Expected VALID_PREFIX state.")
	assert(result["sequence"] == "", "Modifier press test: Expected empty sequence.")
	print("test_modifier_press passed.")

func test_arrow_left() -> void:
	var cm: CheatManager = CheatManager.new()
	cm.load_config()
	# Simulate arrow key press (KEY_LEFT) from VALID_PREFIX with an empty sequence.
	var fake_event: InputEventKey = CheatManagerTest.create_fake_key_event(KEY_LEFT)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "")
	assert(result["sequence"] == "←", "Arrow left test: Expected sequence '←'.")
	assert(result["state"] == CheatManager.CheatInputState.VALID_PREFIX, "Arrow left test: Expected VALID_PREFIX state.")
	print("test_arrow_left passed.")

func test_arrow_up() -> void:
	var cm: CheatManager = CheatManager.new()
	cm.load_config()
	# Simulate arrow key press (KEY_UP) from VALID_PREFIX with sequence "←".
	var fake_event: InputEventKey = CheatManagerTest.create_fake_key_event(KEY_UP)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "←")
	assert(result["sequence"] == "←↑", "Arrow up test: Expected sequence '←↑'.")
	assert(result["state"] == CheatManager.CheatInputState.VALID_PREFIX, "Arrow up test: Expected VALID_PREFIX state.")
	print("test_arrow_up passed.")

func test_arrow_down() -> void:
	var cm: CheatManager = CheatManager.new()
	cm.load_config()
	# Simulate arrow key press (KEY_DOWN) from VALID_PREFIX with sequence "←↑→".
	# "←↑→↓" exactly matches a cheat but is also a prefix for "←↑→↓→", so state should become EXACT_AMBIGUOUS.
	var fake_event: InputEventKey = CheatManagerTest.create_fake_key_event(KEY_DOWN)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "←↑→")
	assert(result["sequence"] == "←↑→↓", "Arrow down test: Expected sequence '←↑→↓'.")
	assert(result["state"] == CheatManager.CheatInputState.EXACT_AMBIGUOUS, "Arrow down test: Expected EXACT_AMBIGUOUS state.")
	print("test_arrow_down passed.")

func test_submit() -> void:
	var cm: CheatManager = CheatManager.new()
	cm.load_config()
	# Simulate submit key press from EXACT_UNAMBIGUOUS state with sequence "←↑→↓→".
	var fake_event: InputEventKey = CheatManagerTest.create_fake_key_event(cm.submit_key)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.SUBMIT, CheatManager.CheatInputState.EXACT_UNAMBIGUOUS, "←↑→↓→")
	assert(result["sequence"] == "", "Submit test: Expected sequence to be reset.")
	assert(result["state"] == CheatManager.CheatInputState.HIDDEN, "Submit test: Expected state to be HIDDEN.")
	print("test_submit passed.")

func test_modifier_release() -> void:
	var cm: CheatManager = CheatManager.new()
	cm.load_config()
	# Simulate modifier key release from ANY state; here using EXACT_UNAMBIGUOUS with sequence "←↑→↓→".
	var result: Dictionary = cm.transition_fn(null, CheatManager.EventType.MODIFIER_RELEASE, CheatManager.CheatInputState.EXACT_UNAMBIGUOUS, "←↑→↓→")
	assert(result["sequence"] == "", "Modifier release test: Expected sequence to be reset.")
	assert(result["state"] == CheatManager.CheatInputState.HIDDEN, "Modifier release test: Expected state to be HIDDEN.")
	print("test_modifier_release passed.")

func run_all_tests() -> void:
	test_modifier_press()
	test_arrow_left()
	test_arrow_up()
	test_arrow_down()
	test_submit()
	test_modifier_release()
	print("All CheatManager transition_fn tests passed!")

func test() -> void:
	run_all_tests()
