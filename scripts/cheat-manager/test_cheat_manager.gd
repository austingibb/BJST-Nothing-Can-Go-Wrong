extends GutTest
class_name CheatManagerTest

# written by: Austingibb w/ ChatGPT o3-mini-high
# date: 2025-03-07
# description: Tests cheat manager transitions.
# notes: This is currently unverified to be adequate tests, I need to put more time in. As of right now this is 90% ChatGPT o3-mini-high generated code.

var cm: CheatManager

# Setup before each test
func before_each() -> void:
	cm = CheatManager.new()
	cm.load_config()

# Teardown after each test
func after_each() -> void:
	cm.queue_free()

# Test: Modifier Key Activation (User Story: Modifier Key Activation)
func test_modifier_press() -> void:
	var fake_event: InputEventKey = create_fake_event(cm.modifier_key)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.MODIFIER_PRESS, CheatManager.CheatInputState.HIDDEN, "")
	assert_eq(result["state"], CheatManager.CheatInputState.VALID_PREFIX, "Expected VALID_PREFIX state.")
	assert_eq(result["sequence"], "", "Expected empty sequence.")
	gut.p("test_modifier_press passed", 2)

# Test: Arrow Key Input (User Story: Arrow Key Input)
func test_arrow_left() -> void:
	var fake_event: InputEventKey = create_fake_event(KEY_LEFT)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "")
	assert_eq(result["sequence"], "←", "Expected sequence '←'.")
	assert_eq(result["state"], CheatManager.CheatInputState.VALID_PREFIX, "Expected VALID_PREFIX state.")
	gut.p("test_arrow_left passed", 2)

func test_arrow_up() -> void:
	var fake_event: InputEventKey = create_fake_event(KEY_UP)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "←")
	assert_eq(result["sequence"], "←↑", "Expected sequence '←↑'.")
	assert_eq(result["state"], CheatManager.CheatInputState.VALID_PREFIX, "Expected VALID_PREFIX state.")
	gut.p("test_arrow_up passed", 2)

func test_arrow_down() -> void:
	var fake_event: InputEventKey = create_fake_event(KEY_DOWN)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "←↑→")
	assert_eq(result["sequence"], "←↑→↓", "Expected sequence '←↑→↓'.")
	assert_eq(result["state"], CheatManager.CheatInputState.EXACT_AMBIGUOUS, "Expected EXACT_AMBIGUOUS state.")
	gut.p("test_arrow_down passed", 2)

# Test: Ambiguity Handling (User Story: Ambiguity Handling)
func test_ambiguous_cheat_sequence() -> void:
	var fake_event: InputEventKey = create_fake_event(KEY_UP)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "")
	result = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "←")
	assert_eq(result["state"], CheatManager.CheatInputState.VALID_PREFIX, "Expected state to remain VALID_PREFIX for an ambiguous sequence.")
	gut.p("test_ambiguous_cheat_sequence passed", 2)

# Test: Submit Confirmation (User Story: Submit Confirmation)
func test_submit() -> void:
	var fake_event: InputEventKey = create_fake_event(KEY_DOWN)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.SUBMIT, CheatManager.CheatInputState.EXACT_UNAMBIGUOUS, "←↑→↓→")
	assert_eq(result["sequence"], "", "Expected sequence reset after submission.")
	assert_eq(result["state"], CheatManager.CheatInputState.HIDDEN, "Expected state to reset to HIDDEN.")
	gut.p("test_submit passed", 2)

# Test: Non-Automatic Submission and Reset (User Story: Non-Automatic Submission and Reset)
func test_no_automatic_acceptance() -> void:
	var fake_event: InputEventKey = create_fake_event(KEY_DOWN)
	var result: Dictionary = cm.transition_fn(fake_event, CheatManager.EventType.ARROW, CheatManager.CheatInputState.VALID_PREFIX, "")
	assert_ne(result["state"], CheatManager.CheatInputState.EXACT_UNAMBIGUOUS, "Expected system to wait for submit, not automatically activate a cheat.")
	gut.p("test_no_automatic_acceptance passed", 2)

# Test: Modifier Key Release (User Story: Handling Scene Changes)
func test_modifier_release() -> void:
	var result: Dictionary = cm.transition_fn(null, CheatManager.EventType.RESET, CheatManager.CheatInputState.EXACT_UNAMBIGUOUS, "←↑→↓→")
	assert_eq(result["sequence"], "", "Expected sequence reset on modifier release.")
	assert_eq(result["state"], CheatManager.CheatInputState.HIDDEN, "Expected state reset to HIDDEN.")
	gut.p("test_modifier_release passed", 2)

# Helper function to create a fake InputEventKey.
func create_fake_event(keycode: Key) -> InputEventKey:
	var event: InputEventKey = InputEventKey.new()
	event.keycode = keycode
	event.pressed = true
	return event

# Run all tests
func test() -> void:
	test_modifier_press()
	test_arrow_left()
	test_arrow_up()
	test_arrow_down()
	test_ambiguous_cheat_sequence()
	test_submit()
	test_no_automatic_acceptance()
	test_modifier_release()
	gut.p("All CheatManager transition tests passed!", 2)