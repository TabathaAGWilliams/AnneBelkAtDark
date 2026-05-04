extends CanvasLayer
@onready var grade_bar = $GradeBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grade_bar.value = PlayerStats.grade
	PlayerStats.grade_changed.connect(_on_grade_changed)
	
func _on_grade_changed(new_grade: int) -> void:
	grade_bar.value = new_grade
