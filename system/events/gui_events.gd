extends Node


####################################################
## all the warnings are so godot 
## doesnt show warnings on the debugger
## these signals are used, just not in this script
####################################################


# warning-ignore:unused_signal
signal show_hud
# warning-ignore:unused_signal
signal hide_hud
# warning-ignore:unused_signal
signal hide_hud_except_controls
# warning-ignore:unused_signal
signal hide_full_hud

# warning-ignore:unused_signal
signal text_box_request(texts)
# warning-ignore:unused_signal
signal text_box_skipped

# warning-ignore:unused_signal
signal warning_request(id, text, show_agree_button, show_disagree_button)
# warning-ignore:unused_signal
signal warning_request_accepted(id)
# warning-ignore:unused_signal
signal warning_request_rejected(id)

# warning-ignore:unused_signal
signal show_input_hint(input_hint_id)
# warning-ignore:unused_signal
signal hide_input_hint(input_hint_id)

# warning-ignore:unused_signal
signal show_arena_ended_screen

# warning-ignore:unused_signal
signal show_plant_capture_notification

# warning-ignore:unused_signal
signal toggle_debug_log
# warning-ignore:unused_signal
signal show_debug_log

# warning-ignore:unused_signal
signal show_interact_button
# warning-ignore:unused_signal
signal controls_updated

# warning-ignore:unused_signal
signal mobile_button_displacement_updated(id, value)

# warning-ignore:unused_signal
signal notify_archievement(archievement, notify)

# warning-ignore:unused_signal
signal scene_changed_without_fading
# warning-ignore:unused_signal
signal black_overlay_anim_finished(animation)

# warning-ignore:unused_signal
signal toggle_pause_request

# warning-ignore:unused_signal
signal player_in_skill_tree_area
# warning-ignore:unused_signal
signal player_left_skill_tree_area
# warning-ignore:unused_signal
signal player_near_table
# warning-ignore:unused_signal
signal player_far_from_table
