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
signal projectile_inventory_updated(inventory)
# warning-ignore:unused_signal
signal held_projectile_updated(held_projectile)
# warning-ignore:unused_signal
signal switch_projectile_request()

signal no_projectiles
signal has_projectiles

# warning-ignore:unused_signal
signal freeze_player
# warning-ignore:unused_signal
signal freeze_player_slow_motion
# warning-ignore:unused_signal
signal unfreeze_player()

# warning-ignore:unused_signal
signal player_interacted_mobile
# warning-ignore:unused_signal
signal player_moving
# warning-ignore:unused_signal
signal player_not_moving
# warning-ignore:unused_signal
signal entered_eat_state
# warning-ignore:unused_signal
signal exited_eat_state
# warning-ignore:unused_signal
signal force_exit_from_eat_state

# warning-ignore:unused_signal
signal special_attack_unavailable
# warning-ignore:unused_signal
signal special_attack_tutorial_available
# warning-ignore:unused_signal
signal special_attack_available

# warning-ignore:unused_signal
signal enter_eat_state_request

# warning-ignore:unused_signal
signal bounty_increased
