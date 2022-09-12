extends "res://addons/quiver.beat_em_up/custom_inspectors/states_dropdown/state_dropdown_property.gd"

## Write your doc string for this file here

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const AttackState = preload(
		"res://addons/quiver.beat_em_up/characters/action_states/quiver_action_attack.gd"
)

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _should_add_leaf_node_to_list(node: Node) -> bool:
	var is_attack = node is AttackState 
	var is_custom_attack = node.has_method("is_attack_state") and node.is_attack_state()
	return is_attack or is_custom_attack

### -----------------------------------------------------------------------------------------------