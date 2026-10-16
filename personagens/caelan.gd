extends CharacterBody3D

## Protagonista: anda por clique usando a malha de navegação e interage com quem estiver no alvo.

const DISTANCIA_INTERACAO := 1.8

@export var velocidade := 4.0
@export var velocidade_giro := 10.0

var _alvo_interacao: Node3D

@onready var _agente: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	_agente.target_position = global_position


func mover_para(posicao: Vector3) -> void:
	_alvo_interacao = null
	_agente.target_position = posicao


func interagir_com(alvo: Node3D) -> void:
	_alvo_interacao = alvo
	_agente.target_position = alvo.global_position


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if _alvo_interacao and _distancia_plana(_alvo_interacao.global_position) <= DISTANCIA_INTERACAO:
		_chegar_no_alvo()

	var direcao := Vector3.ZERO
	if not _agente.is_navigation_finished():
		direcao = global_position.direction_to(_agente.get_next_path_position())
		direcao.y = 0.0
		direcao = direcao.normalized()

	velocity.x = direcao.x * velocidade
	velocity.z = direcao.z * velocidade
	if direcao != Vector3.ZERO:
		rotation.y = lerp_angle(rotation.y, atan2(direcao.x, direcao.z), velocidade_giro * delta)
	move_and_slide()


func _chegar_no_alvo() -> void:
	var alvo := _alvo_interacao
	_alvo_interacao = null
	_agente.target_position = global_position
	var olhar := alvo.global_position - global_position
	rotation.y = atan2(olhar.x, olhar.z)
	alvo.interagir(self)


func _distancia_plana(ponto: Vector3) -> float:
	return Vector2(global_position.x, global_position.z).distance_to(Vector2(ponto.x, ponto.z))
