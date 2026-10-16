extends CanvasLayer

## Caixa de diálogo com escolhas, testes de atributo (2d6 + atributo) e marcadores.
## Os diálogos ficam em JSON em res://dados/dialogos/ — formato descrito no README.

signal terminou

const NOMES_ATRIBUTOS := {
	"forca": "Força",
	"destreza": "Destreza",
	"vigor": "Vigor",
	"percepcao": "Percepção",
	"astucia": "Astúcia",
	"presenca": "Presença",
}

var ativo := false

var _dados: Dictionary
var _resultado_teste := ""
var _rng := RandomNumberGenerator.new()
var _painel: PanelContainer
var _nome: Label
var _fala: RichTextLabel
var _opcoes: VBoxContainer


func _ready() -> void:
	layer = 10
	_rng.randomize()
	_montar_interface()
	_painel.hide()


func iniciar(caminho: String, nome: String) -> void:
	var dados: Variant = JSON.parse_string(FileAccess.get_file_as_string(caminho))
	if not dados is Dictionary:
		push_error("Diálogo inválido: %s" % caminho)
		return
	_dados = dados
	_resultado_teste = ""
	_nome.text = nome
	ativo = true
	_painel.show()
	_ir_para(_primeiro_no())


func _input(event: InputEvent) -> void:
	if not ativo or not event is InputEventKey or not event.pressed or event.echo:
		return
	var indice: int = event.keycode - KEY_1
	var botoes := _opcoes.get_children()
	if indice >= 0 and indice < botoes.size():
		botoes[indice].pressed.emit()
		get_viewport().set_input_as_handled()


func _primeiro_no() -> String:
	for entrada in _dados.get("entradas", []):
		if Estado.condicao_atendida(entrada.get("condicao", "")):
			return entrada["no"]
	return "fim"


func _ir_para(id: String) -> void:
	if id == "fim":
		_encerrar()
		return
	var no: Dictionary = _dados["nos"][id]
	_aplicar_definicoes(no)
	_fala.text = _resultado_teste + _interpolar(no["fala"])
	_resultado_teste = ""
	_mostrar_opcoes(no)


func _mostrar_opcoes(no: Dictionary) -> void:
	for botao in _opcoes.get_children():
		_opcoes.remove_child(botao)
		botao.queue_free()

	var opcoes: Array = no.get("opcoes", [])
	if opcoes.is_empty():
		var seguinte: String = no.get("ir", "fim")
		opcoes = [{"texto": "Encerrar" if seguinte == "fim" else "Continuar", "ir": seguinte}]

	var numero := 1
	for opcao in opcoes:
		if not Estado.condicao_atendida(opcao.get("condicao", "")):
			continue
		var botao := Button.new()
		botao.text = "%d. %s%s" % [numero, _rotulo_teste(opcao), _interpolar(opcao["texto"])]
		botao.alignment = HORIZONTAL_ALIGNMENT_LEFT
		botao.add_theme_font_size_override("font_size", 18)
		botao.pressed.connect(_escolher.bind(opcao))
		_opcoes.add_child(botao)
		numero += 1


func _escolher(opcao: Dictionary) -> void:
	_aplicar_definicoes(opcao)
	if not opcao.has("teste"):
		_ir_para(opcao.get("ir", "fim"))
		return

	var teste: Dictionary = opcao["teste"]
	var dado1 := _rng.randi_range(1, 6)
	var dado2 := _rng.randi_range(1, 6)
	var bonus: int = Estado.atributos[teste["atributo"]]
	var dificuldade := int(teste["dificuldade"])
	var total := dado1 + dado2 + bonus
	var sucesso := total >= dificuldade
	_resultado_teste = "[color=#a8a8a8]%s: %d + %d + %d = %d contra %d — %s[/color]\n\n" % [
		NOMES_ATRIBUTOS[teste["atributo"]], dado1, dado2, bonus, total, dificuldade,
		"sucesso" if sucesso else "falha",
	]
	_ir_para(teste["sucesso"] if sucesso else teste["falha"])


func _aplicar_definicoes(origem: Dictionary) -> void:
	var definicoes: Dictionary = origem.get("define", {})
	for chave in definicoes:
		Estado.definir(chave, definicoes[chave])


func _rotulo_teste(opcao: Dictionary) -> String:
	if not opcao.has("teste"):
		return ""
	var teste: Dictionary = opcao["teste"]
	return "[%s %d] " % [NOMES_ATRIBUTOS[teste["atributo"]], int(teste["dificuldade"])]


func _interpolar(texto: String) -> String:
	return texto.format(Estado.marcadores)


func _encerrar() -> void:
	ativo = false
	_painel.hide()
	terminou.emit()


func _montar_interface() -> void:
	_painel = PanelContainer.new()
	_painel.anchor_left = 0.0
	_painel.anchor_right = 1.0
	_painel.anchor_top = 1.0
	_painel.anchor_bottom = 1.0
	_painel.offset_left = 40.0
	_painel.offset_right = -40.0
	_painel.offset_top = -220.0
	_painel.offset_bottom = -24.0
	_painel.grow_vertical = Control.GROW_DIRECTION_BEGIN

	var estilo := StyleBoxFlat.new()
	estilo.bg_color = Color(0.08, 0.07, 0.06, 0.92)
	estilo.border_color = Color(0.55, 0.45, 0.3)
	estilo.set_border_width_all(2)
	estilo.set_corner_radius_all(6)
	estilo.set_content_margin_all(20.0)
	_painel.add_theme_stylebox_override("panel", estilo)
	add_child(_painel)

	var coluna := VBoxContainer.new()
	coluna.add_theme_constant_override("separation", 12)
	_painel.add_child(coluna)

	_nome = Label.new()
	_nome.add_theme_font_size_override("font_size", 22)
	_nome.add_theme_color_override("font_color", Color(0.9, 0.75, 0.45))
	coluna.add_child(_nome)

	_fala = RichTextLabel.new()
	_fala.bbcode_enabled = true
	_fala.fit_content = true
	_fala.add_theme_font_size_override("normal_font_size", 20)
	coluna.add_child(_fala)

	_opcoes = VBoxContainer.new()
	_opcoes.add_theme_constant_override("separation", 6)
	coluna.add_child(_opcoes)
