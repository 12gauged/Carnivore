extends Component

onready var CurrentArena: Node2D = toolbox.get_node_in_group("arena")

func start_arena(): CurrentArena.start_arena()
