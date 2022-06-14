extends "res://characters/playable/chad/states/chad_state.gd"

## Write your doc string for this file here

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const MoveState = preload("res://characters/playable/chad/states/move.gd")

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

@onready var _move_state := get_parent() as MoveState

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	super()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func enter(msg: = {}) -> void:
	super(msg)
	_move_state.enter(msg)
	_skin.transition_to(_skin.SkinStates.WALK)


func unhandled_input(event: InputEvent) -> void:
	var has_handled := false
	if not has_handled:
		get_parent().unhandled_input(event)


func physics_process(delta: float) -> void:
	_move_state._direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var facing_direction :int = sign(_move_state._direction.x)
	if facing_direction != 0:
		_skin.scale.x = facing_direction
	
	if _move_state._direction == Vector2.ZERO:
		_state_machine.transition_to("Ground/Move/Idle")
	
	_move_state.physics_process(delta)


func exit() -> void:
	super()
	_move_state.exit()

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------
