class_name QuiverAiState
extends QuiverState

## Write your doc string for this file here

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _character: QuiverCharacter = null
var _actions: QuiverStateMachine = null

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	super()
	if is_instance_valid(owner):
		await owner.ready
		_on_owner_ready()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func get_list_of_action_states() -> Array:
	var list := ["Node not ready yet"]
	if _actions == null:
		return list
	
	list = _actions.get_leaf_nodes_path_list()
	return list


func get_list_of_ai_states() -> Array:
	var list := ["Node not ready yet"]
	if _state_machine == null:
		return list
	
	list = _state_machine.get_list_of_ai_states()
	return list

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_owner_ready() -> void:
	_character = owner
	_actions = _character._state_machine

### -----------------------------------------------------------------------------------------------

