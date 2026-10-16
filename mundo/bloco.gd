@tool
extends StaticBody3D

## Obstáculo feito de primitivas (casa, carroça, cerca) enquanto o jogo não tem modelos 3D.
## A base fica no chão: o bloco cresce para cima a partir da posição do nó.

@export var tamanho := Vector3(2, 2, 2):
	set(valor):
		tamanho = valor
		_montar()
@export var cor := Color(0.55, 0.42, 0.3):
	set(valor):
		cor = valor
		_montar()
## 0 = sem telhado.
@export var altura_telhado := 0.0:
	set(valor):
		altura_telhado = valor
		_montar()
@export var cor_telhado := Color(0.35, 0.22, 0.16):
	set(valor):
		cor_telhado = valor
		_montar()

var _gerados: Array[Node] = []


func _ready() -> void:
	_montar()


func _montar() -> void:
	if not is_inside_tree():
		return
	for no in _gerados:
		no.free()
	_gerados.clear()

	var caixa := BoxMesh.new()
	caixa.size = tamanho
	caixa.material = _material(cor)
	_adicionar_malha(caixa, tamanho.y / 2.0)

	var forma := BoxShape3D.new()
	forma.size = tamanho
	var colisao := CollisionShape3D.new()
	colisao.shape = forma
	colisao.position.y = tamanho.y / 2.0
	_adicionar(colisao)

	if altura_telhado > 0.0:
		var telhado := PrismMesh.new()
		telhado.size = Vector3(tamanho.x + 0.4, altura_telhado, tamanho.z + 0.4)
		telhado.material = _material(cor_telhado)
		_adicionar_malha(telhado, tamanho.y + altura_telhado / 2.0)


func _adicionar_malha(malha: Mesh, altura: float) -> void:
	var instancia := MeshInstance3D.new()
	instancia.mesh = malha
	instancia.position.y = altura
	_adicionar(instancia)


func _adicionar(no: Node) -> void:
	add_child(no)
	_gerados.append(no)


func _material(cor_base: Color) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = cor_base
	material.roughness = 0.9
	return material
