extends Node

signal collect_tag()
signal return_tag(tag)
signal update_tag(tag)
signal spawn(tag)
signal open_menu
signal close_menu
signal noise(position_from, loudness, name)

func emit_close_menu():
    close_menu.emit()
func emit_open_menu():
    open_menu.emit()

func emit_update_tag(tag: int):
    update_tag.emit(tag)

func emit_collect_tag():
    collect_tag.emit()

func emit_return_tag(tag: int):
    return_tag.emit(tag)

func emit_spawn(tag: int):
    spawn.emit(tag)
 
func emit_noise(position_from: Vector3, loudness: float, sound_name: String):
    noise.emit(position_from, loudness, sound_name) 