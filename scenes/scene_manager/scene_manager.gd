extends Node
class_name SceneManager

@export var world2d: Node2D
@export var gui: Control
@export var transition_manager: TransitionManager

var curr_2d_scene: Node2D
var curr_gui_scene: Control

var curr_2d_scene_name: GlobalEnums.SceneName
var curr_gui_scene_name: GlobalEnums.SceneName

# Room
const apartment: String = "res://scenes/rooms/apartment.tscn"
const kitchen: String = "res://scenes/rooms/kitchen.tscn"
const hallway: String = "res://scenes/rooms/hallway.tscn"
const factory: String = "res://scenes/factory_mini_game/factory_mini_game.tscn"
# UI
const main_menu: String = "res://scenes/ui/main_menu.tscn"
const pause_menu: String = "res://scenes/ui/pause_menu.tscn"
const settings_menu: String = "res://scenes/ui/settings_menu.tscn"
const end_screen: String = "res://scenes/ui/end_screen.tscn"
# Manager
const splash_screen_manager: String = "res://scenes/splash_screen_manager/splash_screen_manager.tscn"

func _ready() -> void:
	Global.scene_manager = self
	change_gui_scene(
		GlobalEnums.SceneName.SplashScreen,
		true,
		false,
		false,
	)

# a pause menu
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		# checks if the world3d has children aka gamein in play
		if world2d.get_children().size() > 0:
			var children: Array[Node] = gui.get_children()
			if children.size() > 0:
				get_tree().paused = !get_tree().paused
				for child in children:
					child.queue_free()
			else:
				if Dialogic.current_timeline == null:
					get_tree().paused = !get_tree().paused
					Global.scene_manager.change_gui_scene(
						GlobalEnums.SceneName.PauseMenu,
						true,
						false,
						false
					)
	if Input.is_action_just_pressed("reset"):
		if world2d.get_children().size() > 0:
			var children: Array[Node] = gui.get_children()
			if children.size() > 0:
				pass
			else:
				if Dialogic.current_timeline == null:
					reset_2d_scene()

func get_scene(scene_name: GlobalEnums.SceneName) -> Node:
	match scene_name:
		GlobalEnums.SceneName.SplashScreen:
			return load(splash_screen_manager).instantiate()
		GlobalEnums.SceneName.MainMenu:
			return load(main_menu).instantiate()
		GlobalEnums.SceneName.PauseMenu:
			return load(pause_menu).instantiate()
		GlobalEnums.SceneName.SettingsMenu:
			return load(settings_menu).instantiate()
		GlobalEnums.SceneName.EndScreen:
			return load(end_screen).instantiate()
		GlobalEnums.SceneName.Apartment:
			return load(apartment).instantiate()
		GlobalEnums.SceneName.Kitchen:
			return load(kitchen).instantiate()
		GlobalEnums.SceneName.Hallway:
			return load(hallway).instantiate()
		GlobalEnums.SceneName.Factory:
			return load(factory).instantiate()
		_ :
			return load(main_menu).instantiate()

func reset_2d_scene(
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "fade_in",
	transition_out: String = "fade_out",
	seconds: float = 1.0
) -> void:
	if transition:
		transition_manager.transition(transition_out, seconds)
		await transition_manager.animation_player.animation_finished
	if curr_2d_scene != null:
		if delete: 
			curr_2d_scene.queue_free()
		elif keep_running:
			curr_2d_scene.visible = false
		else:
			gui.remove_child(curr_2d_scene)
	var new_scene_obj: Node2D = get_scene(curr_2d_scene_name)
	world2d.add_child(new_scene_obj)
	curr_2d_scene = new_scene_obj
	if transition:
		transition_manager.transition(transition_in, seconds)
	# Reset gui and un pause the game
	var children: Array[Node] = gui.get_children()
	if children.size() > 0:
		get_tree().paused = !get_tree().paused
		for child in children:
			child.queue_free()

func change_2d_scene(
	scene_name: GlobalEnums.SceneName,
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "fade_in",
	transition_out: String = "fade_out",
	seconds: float = 1.0
) -> void:
	curr_2d_scene_name = scene_name
	if transition:
		transition_manager.transition(transition_out, seconds)
		await transition_manager.animation_player.animation_finished
	if curr_2d_scene != null:
		if delete: 
			curr_2d_scene.queue_free()
		elif keep_running:
			curr_2d_scene.visible = false
		else:
			gui.remove_child(curr_2d_scene)
	var new_scene_obj: Node2D = get_scene(scene_name)
	world2d.add_child(new_scene_obj)
	curr_2d_scene = new_scene_obj
	if transition:
		transition_manager.transition(transition_in, seconds)

func change_gui_scene(
	scene_name: GlobalEnums.SceneName,
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "fade_in",
	transition_out: String = "fade_out",
	seconds: float = 1.0
) -> void:
	curr_gui_scene_name = scene_name
	if transition:
		transition_manager.transition(transition_out, seconds)
		await transition_manager.animation_player.animation_finished
	if curr_gui_scene != null:
		if delete: 
			curr_gui_scene.queue_free()
		elif keep_running:
			curr_gui_scene.visible = false
		else:
			gui.remove_child(curr_gui_scene)
	var new_scene_obj: Control = get_scene(scene_name)
	gui.add_child(new_scene_obj)
	curr_gui_scene = new_scene_obj
	if transition:
		transition_manager.transition(transition_in, seconds)

func load_room(
	scene_name: GlobalEnums.SceneName,
	 spawn_string: String, 
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "fade_in",
	transition_out: String = "fade_out",
	seconds: float = 1.0
) -> void:
	await Global.scene_manager.change_2d_scene(
		scene_name,
		delete,
		keep_running,
		transition,
		transition_in,
		transition_out,
		seconds
	)
	var current_scene: Node2D = Global.scene_manager.curr_2d_scene
	print(current_scene)
	if spawn_string == "N/A":
		print("Spawning without spawn point.")
	elif current_scene.has_node(spawn_string):
		print(spawn_string)
		var spawn_point: Node = current_scene.get_node(spawn_string)
		print(spawn_point)
		var spawn_position: Vector2 = spawn_point.global_position
		var player : CharacterBody2D = current_scene.get_node("Player")
		player.global_position = spawn_position
