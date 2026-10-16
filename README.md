# Algum Jogo Qualquer

CRPG 3D por turnos, de fantasia pé no chão com clima de faroeste. O design está em [docs/design.md](docs/design.md).

## Rodando

1. Instale o [Godot 4.7](https://godotengine.org/download) (versão padrão, não a .NET).
2. Abra o Godot, clique em **Importar** e escolha o `project.godot` desta pasta.
3. Aperte **F5** para rodar.

## Controles

| Ação | Comando |
|---|---|
| Andar | Clique no chão |
| Conversar | Clique no NPC |
| Escolher fala | Clique na opção ou tecla 1–9 |
| Girar câmera | Q / E, botão do meio arrastando ou dois dedos na horizontal no trackpad |
| Zoom | Roda do mouse, pinça ou dois dedos na vertical no trackpad |

## Estrutura

```
camera/        câmera CRPG
personagens/   Caelan e NPCs
mundo/         níveis e blocos de cenário (primitivas provisórias)
sistemas/      autoloads: Estado (atributos e marcadores) e Dialogo
dados/         conteúdo em dados (diálogos em JSON)
docs/          documento de design
```

## Formato de diálogo

Arquivos em `dados/dialogos/*.json`:

```json
{
	"entradas": [
		{ "condicao": "escolta_aceita", "no": "ja_contratado" },
		{ "no": "abertura" }
	],
	"nos": {
		"abertura": {
			"fala": "Texto do NPC. Aceita {marcador} para interpolar.",
			"define": { "marcador": true },
			"opcoes": [
				{ "texto": "Ir para outro nó", "ir": "outro_no" },
				{ "texto": "Só aparece se...", "condicao": "!recusou", "ir": "fim" },
				{
					"texto": "Teste de atributo",
					"teste": { "atributo": "astucia", "dificuldade": 8, "sucesso": "a", "falha": "b" }
				}
			]
		}
	}
}
```

- `entradas`: o primeiro item com a condição atendida define onde a conversa começa.
- `define`: grava marcadores no `Estado`, ao entrar num nó ou ao escolher uma opção.
- `condicao`: nome do marcador (`"x"`) ou a negação dele (`"!x"`).
- `teste`: rola 2d6 + atributo do Caelan contra a dificuldade.
- `"fim"` encerra a conversa. Nó sem `opcoes` mostra **Continuar** (se tiver `ir`) ou **Encerrar**.

Ao exportar o jogo, inclua `*.json` em **Filtros para exportar arquivos não-recurso**, senão os diálogos não entram no build.
