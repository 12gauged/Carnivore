extends Node

# warning-ignore:unused_signal
signal meat_consumed

# warning-ignore:unused_signal
signal status_value_update(stat_id, value, animate)
# warning-ignore:unused_signal
signal set_stat_value(stat_id, value)

# warning-ignore:unused_signal
signal projectile_collected(projectile)
# warning-ignore:unused_signal
signal projectile_thrown()

# warning-ignore:unused_signal
signal entered_eat_state
# warning-ignore:unused_signal
signal exited_eat_state
# warning-ignore:unused_signal
signal force_exit_from_eat_state

# warning-ignore:unused_signal
signal enter_eat_state_request

# warning-ignore:unused_signal
signal archievement_made(archievement, nofity)
# warning-ignore:unused_signal
signal notify_archievement(archievement)
