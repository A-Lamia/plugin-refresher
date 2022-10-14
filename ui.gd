@tool
extends Control

@onready var popup = %plugin_list.get_popup();

func plugin_refresh(plugin_name) -> void:
	var Editor = EditorPlugin.new().get_editor_interface()
	var plugin_path: String = "res://addons/" + plugin_name + "/plugin.cfg"
	var is_plugin_enabled = Editor.is_plugin_enabled(plugin_path)

		
	if is_plugin_enabled == true:
		Editor.set_plugin_enabled(plugin_path, false)
		Editor.set_plugin_enabled(plugin_path, true)
	else:
		print("Not a directory: " + plugin_path)

	
func populate_popup_menu(popup) -> void:
	var dir = DirAccess.open("res://addons")
	
	if dir:
		dir.list_dir_begin();
		var file_name = dir.get_next();
		
		while file_name != "":
			if dir.current_is_dir() and file_name != "addon_refresher":
				popup.add_item(file_name)
			file_name = dir.get_next();
		dir.list_dir_end();


func _on_refresh_pressed() -> void:
	plugin_refresh(%plugin_list.text);

func _on_item_pressed(ID) -> void:
	%plugin_list.text = popup.get_item_text(ID);

func _ready():
	populate_popup_menu(popup);
	popup.id_pressed.connect(_on_item_pressed);
