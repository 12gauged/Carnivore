extends Timer

func start_timer(): 
	debug_log.call_deferred("dprint", "starting timer %s" % self.name)
	start()
func stop_timer(): stop()
