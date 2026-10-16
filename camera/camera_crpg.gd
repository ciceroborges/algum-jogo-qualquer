extends Node3D

## Câmera inclinada estilo CRPG: segue o alvo, gira com Q/E (ou botão do meio / trackpad)
## e aproxima com a roda do mouse ou pinça.

@export var alvo: Node3D
@export_range(30.0, 80.0) var inclinacao := 55.0
@export var distancia_minima := 7.0
@export var distancia_maxima := 32.0
@export var velocidade_giro := 90.0
@export var suavidade := 8.0

var _distancia := 20.0
var _distancia_alvo := 20.0
var _girando_com_mouse := false

@onready var _camera: Camera3D = $Camera3D


func _ready() -> void:
	if alvo:
		global_position = alvo.global_position


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if event.pressed:
					_aproximar(-1.5)
			MOUSE_BUTTON_WHEEL_DOWN:
				if event.pressed:
					_aproximar(1.5)
			MOUSE_BUTTON_MIDDLE:
				_girando_com_mouse = event.pressed
	elif event is InputEventMouseMotion and _girando_com_mouse:
		rotation.y -= event.relative.x * 0.005
	elif event is InputEventPanGesture:
		_aproximar(event.delta.y * 0.5)
		rotation.y -= event.delta.x * 0.05
	elif event is InputEventMagnifyGesture:
		_distancia_alvo = clampf(_distancia_alvo / event.factor, distancia_minima, distancia_maxima)


func _process(delta: float) -> void:
	var giro := Input.get_axis("camera_girar_direita", "camera_girar_esquerda")
	rotation.y += deg_to_rad(velocidade_giro) * giro * delta

	# Suavização independente de FPS.
	var peso := 1.0 - exp(-suavidade * delta)
	_distancia = lerpf(_distancia, _distancia_alvo, peso)
	if alvo:
		global_position = global_position.lerp(alvo.global_position, peso)

	var angulo := deg_to_rad(inclinacao)
	_camera.position = Vector3(0.0, sin(angulo), cos(angulo)) * _distancia
	_camera.rotation = Vector3(-angulo, 0.0, 0.0)


func _aproximar(quanto: float) -> void:
	_distancia_alvo = clampf(_distancia_alvo + quanto, distancia_minima, distancia_maxima)
