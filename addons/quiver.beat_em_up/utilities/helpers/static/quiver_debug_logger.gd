class_name QuiverDebugLogger
extends Resource

# Simple class to log

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const LOG_FOLDER = "user://debug_log/"
const LOG_FILE = LOG_FOLDER+"%s_debug_session.csv"
const RELEASE_LOG_FILE = LOG_FOLDER+"%s_session.csv"

#--- public variables - order: export > normal var > onready --------------------------------------

@export_range(0,1,1,"or_greater") var max_logs := 5

#--- private variables - order: export > normal var > onready -------------------------------------

var _current_log := PackedStringArray()
var _current_log_file := ""

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _init() -> void:
	_clear_old_logs()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE and not _current_log.is_empty():
		var dir := Directory.new()
		if not dir.dir_exists("user://debug_log/"):
			dir.make_dir_recursive("user://debug_log/")
		
		# Improve this later to make it properly with all the error checks
		var file = File.new()
		file.open(_current_log_file, File.WRITE)
		file.store_string("\n".join(_current_log))
		file.close()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

static func get_logger() -> QuiverDebugLogger:
	var value := load("res://addons/quiver.beat_em_up/utilities/quiver_debug_logger.tres") \
			as QuiverDebugLogger
	return value


func start_new_log() -> void:
	if not _is_logging_enabled():
		return
	
	var file_path = LOG_FILE if OS.has_feature("debug") else RELEASE_LOG_FILE
	var date_time := Time.get_datetime_string_from_system().replace(":", "-")
	_current_log_file = file_path%[date_time]


func log_message(msg: PackedStringArray) -> void:
	if not _is_logging_enabled() or not _has_created_log_file():
		return
	
	var date_time := Time.get_datetime_string_from_system()
	var log_entry: = "%s,%09d,%s"%[date_time, Time.get_ticks_msec(), ",".join(msg)]
	_current_log.append(log_entry)

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _clear_old_logs() -> void:
	var dir := Directory.new()
	var files := PackedStringArray()
	if dir.dir_exists("user://debug_log/"):
		var error := dir.open("user://debug_log/")
		if error == OK:
			files = dir.get_files()
			
			if files.size() > max_logs:
				for index in range(files.size()-max_logs):
					var file_path := files[index]
					dir.remove(file_path)
		else:
			push_error("Could not open user://debug_log/ Error Code: %s"%[error])


func _is_logging_enabled() -> bool:
	return ProjectSettings.get_setting(QuiverCyclicHelper.SETTINGS_LOGGING) and OS.is_debug_build()


func _has_created_log_file() -> bool:
	return not _current_log_file.is_empty()

### -----------------------------------------------------------------------------------------------