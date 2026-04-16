extends Node

signal grade_changed(new_grade: int)

const MAX_GRADE: int = 100
var grade: int = 0:
	set(value):
		grade = clamp(value, 0, MAX_GRADE)
		grade_changed.emit(grade)
		
	
func points_added(amount: int) -> void:
	grade += amount

func points_deducted(amount: int) -> void:
	grade -= amount 
