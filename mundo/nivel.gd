extends Node3D

## Nível de teste: gera a malha de navegação e traduz cliques em ordens para o Caelan.

const ALCANCE_CLIQUE := 200.0

@onready var _caelan: CharacterBody3D = $Caelan
@onready var _camera: Camera3D = $CameraCRPG/Camera3D
@onready var _navegacao: NavigationRegion3D = $Navegacao


func _ready() -> void:
	_navegacao.bake_navigation_mesh(false)


func _unhandled_input(event: InputEvent) -> void:
	if Dialogo.ativo:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_tratar_clique(event.position)


func _tratar_clique(posicao_tela: Vector2) -> void:
	var origem := _camera.project_ray_origin(posicao_tela)
	var destino := origem + _camera.project_ray_normal(posicao_tela) * ALCANCE_CLIQUE
	var acerto := get_world_3d().direct_space_state.intersect_ray(
		PhysicsRayQueryParameters3D.create(origem, destino)
	)
	if acerto.is_empty():
		return
	if acerto.collider.is_in_group("interagivel"):
		_caelan.interagir_com(acerto.collider)
	else:
		_caelan.mover_para(acerto.position)
