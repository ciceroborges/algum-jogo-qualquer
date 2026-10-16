extends Node

## Estado global da partida: atributos do Caelan e marcadores da história.

var atributos := {
	"forca": 2,
	"destreza": 3,
	"vigor": 2,
	"percepcao": 2,
	"astucia": 1,
	"presenca": 1,
}

## Fatos da história ("escolta_aceita": true, "pagamento": 30...). Usados em condições e textos.
var marcadores := {}


func definir(nome: String, valor: Variant) -> void:
	# JSON entrega todo número como float; inteiros voltam a ser int para aparecer como "30", não "30.0".
	if valor is float and valor == floorf(valor):
		valor = int(valor)
	marcadores[nome] = valor


## Condição vazia é sempre verdadeira; "!nome" nega o marcador.
func condicao_atendida(condicao: String) -> bool:
	if condicao.is_empty():
		return true
	if condicao.begins_with("!"):
		return not bool(marcadores.get(condicao.substr(1), false))
	return bool(marcadores.get(condicao, false))
