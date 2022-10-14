@tool
extends EditorPlugin

const DockPanel = preload("res://addons/plugin-refresher/ui.tscn")
var dock_panel

func _enter_tree():
	dock_panel = DockPanel.instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, dock_panel)



func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, dock_panel)
	dock_panel.free()
	
