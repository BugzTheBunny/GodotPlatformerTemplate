extends Node

signal health_changed(node: Node, amount_changed: int)

func on_health_changed(node: Node, amount_changed: int):
	health_changed.emit(node, amount_changed)
