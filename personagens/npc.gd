extends StaticBody3D

## Personagem com quem o Caelan pode conversar ao clicar nele.

@export var nome := "Desconhecido"
@export_file("*.json") var dialogo: String


func _ready() -> void:
	add_to_group("interagivel")
	$Nome.text = nome


func interagir(quem: Node3D) -> void:
	var olhar := quem.global_position - global_position
	rotation.y = atan2(olhar.x, olhar.z)
	Dialogo.iniciar(dialogo, nome)
