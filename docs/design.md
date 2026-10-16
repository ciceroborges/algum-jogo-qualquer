# Documento de design — versão 0.1

> Título provisório. Documento vivo: atualizar sempre que uma decisão mudar.

## Premissa

Um CRPG 3D por turnos, de fantasia pé no chão com clima de faroeste. Caelan, um andarilho que vive de trabalhos pela estrada, encontra a primeira pista sobre os homens que mataram seu protetor anos atrás. Seguir essa pista significa atravessar uma província de fronteira onde viajar cansa, a comida acaba, ferimentos demoram a curar e cada briga pode ser a última.

## Pilares

1. **A estrada é o jogo.** Viajar exige planejamento: comida, água, descanso e rota.
2. **Lutar custa caro.** Combate é perigoso e deixa sequelas. Conversar, negociar, se esconder ou ir embora costumam ser opções melhores.
3. **Um homem comum num mundo comum.** Sem magia, sem heróis predestinados. O mistério está nas pessoas e no passado.
4. **Escolhas com consequência.** Quem você poupa, em quem confia e o que aceita fazer por dinheiro mudam o que acontece depois.

## Mundo

- **Tom:** fantasia de baixa tecnologia, pé no chão, com estética e ritmo de faroeste: fronteira, vilas isoladas, estradas perigosas, lei fraca.
- **Sem magia.** O que mais se aproxima disso é a **alquimia prática**: frascos que explodem ou fazem fumaça, flechas com pólvora, venenos, remédios. Superstições e boatos existem, mas nada sobrenatural é real.
- **Fauna:** lobos, ursos, javalis, cervos, coelhos, peixes. Animais selvagens são ameaça e fonte de comida.
- **Ocupação humana:** pequenas províncias. Uma cidade principal (capital da região), vilas no estilo faroeste, fazendas isoladas, acampamentos, postos de estrada e ruínas antigas.
- **História de fundo:** séculos atrás, uma dinastia de reis-arqueiros governava a região. O reino caiu e a linhagem foi dada como extinta. Hoje restam ruínas, canções e um símbolo que pouca gente reconhece.

## Protagonista: Caelan

- **Fixo:** nome, rosto e passado definidos. O jogador define atributos, habilidades e a postura nos diálogos.
- **Passado:** não conheceu os pais. Foi criado pelo **Caçador**, um protetor que nunca disse o próprio nome. Ele ensinou Caelan a caçar, rastrear, lutar e fugir, e repetia: *"Sua linhagem é importante. Lembre-se disso. E sobreviva."* Morreu, ou desapareceu, numa emboscada de três homens enquanto Caelan fugia. Depois disso Caelan cresceu nas ruas de uma cidade portuária e virou andarilho e mercenário.
- **O segredo que ele não conhece:** é descendente distante dos reis-arqueiros. O Caçador escondeu seu sobrenome para protegê-lo.
- **Personalidade:** independente, desconfiado, pragmático. Trabalha por dinheiro, mas tem limites: não mata inocentes por encomenda e não tolera crueldade gratuita. É um líder relutante.
- **Armas:** **arco** (principal) e **adaga** (curta distância, último recurso).
- **Arco do personagem:** a primeira versão não resolve a linhagem. Ela só abre a pergunta e obriga Caelan a decidir se continua fugindo daquela estrada.

### Gancho da primeira versão (proposta)

Caelan aceita escoltar uma caravana até uma vila de fronteira. No caminho, a caravana é atacada por homens que usam o **mesmo símbolo** dos assassinos do Caçador. É a primeira pista em anos. Para segui-la, ele precisa descobrir quem manda nesses homens e decidir em quem confiar.

## Loop principal

```
Cidade/vila → aceitar trabalho, comprar suprimentos, conversar
     ↓
Mapa de viagem → escolher rota, gastar tempo/comida/água, eventos na estrada
     ↓
Local explorável (3D) → investigar, conversar, se esgueirar, lutar se preciso
     ↓
Acampamento / estalagem → comer, tratar ferimentos, dormir, salvar
     ↓
(de volta à estrada)
```

## Sistemas

### Viagem

- **Mapa da região** com locais conectados por estradas e trilhas. Escolher um destino avança o tempo e consome recursos.
- **Eventos na estrada:** cenas curtas com escolhas (animais rondando, viajante ferido, rastro de caça, bandidos cobrando pedágio, ponte quebrada). Alguns levam a um combate ou a uma área 3D pequena.
- **Rotas:** a estrada principal é mais segura e mais longa. Trilhas são mais curtas, mas têm mais risco e menos água.
- **Cavalo:** fora da primeira versão. Depois: viagem mais rápida e mais carga, mas precisa comer, pode se ferir, se assustar ou ser roubado.

### Sobrevivência

- **Necessidades:** fome, sede e cansaço. Avançam com o **tempo de jogo** (viagem, espera, descanso), nunca em tempo real.
- **Efeitos graduais**, sem morte súbita:
  - Fome: menos precisão e vigor.
  - Sede: menos vigor e mais penalidade em testes físicos.
  - Cansaço: menos percepção e piora nos testes de diálogo.
- **Fontes de comida e água:** comprar, caçar, pescar, coletar, rios e poços. Comida estraga com o tempo; carne crua precisa de fogueira.
- **Caça** usa o mesmo sistema do combate: rastrear, se aproximar em silêncio, atirar. Um coelho é fácil, um cervo exige paciência e um urso é um perigo real.

### Ferimentos e cura

- Além dos pontos de vida, existem **ferimentos com efeitos e tratamentos próprios**:

| Ferimento | Efeito | Tratamento |
|---|---|---|
| Corte | Sangramento | Curativo |
| Flecha cravada | Dano ao se mover | Extrair e fazer curativo |
| Braço ferido | Penalidade grande no arco | Tala e repouso |
| Costela quebrada | Menos vigor | Repouso prolongado |
| Infecção / febre | Piora com o tempo | Remédio ou curandeiro |

- Ferimentos **duram dias de jogo**. Dormir e descansar aceleram a recuperação; curandeiros nas vilas tratam casos graves, cobrando por isso.

### Combate por turnos

- **Iniciativa**, movimento livre dentro de um alcance e ações limitadas por turno.
- **Arco:** precisa de linha de visão; terreno alto e cobertura importam; atirar com um inimigo colado é penalizado.
- **Tipos de flecha:** comum, de caça, com pólvora (explode), incendiária, de fumaça.
- **Adaga:** ataque corpo a corpo e golpe silencioso em alvos desatentos.
- **Itens alquímicos:** frascos explosivos, bombas de fumaça, venenos de lâmina.
- **Furtividade:** começar o combate sem ser visto dá um primeiro tiro com bônus.
- **Inimigos humanos têm moral:** fogem, se rendem ou pedem para negociar quando a luta vira. Poupar ou matar tem consequências.
- **Animais** seguem instinto: lobos cercam e testam, ursos atacam quando se sentem ameaçados e fogem se feridos.

### Diálogo e alternativas ao combate

- Diálogos com escolhas e **testes de atributo** (persuadir, intimidar, enganar, perceber mentiras).
- O estado do Caelan afeta os testes: ferido, faminto ou exausto, ele convence e intimida pior.
- Quase todo encontro com humanos deve ter pelo menos uma saída sem luta: conversa, suborno, ameaça, furtividade, fuga.
- **Reputação** por vila e facção: o que você faz em um lugar chega aos outros.

### Atributos (rascunho)

- **Força:** carga, adaga, puxar arcos pesados.
- **Destreza:** precisão, furtividade.
- **Vigor:** resistência a ferimentos, fome e cansaço.
- **Percepção:** rastrear, notar emboscadas e mentiras.
- **Astúcia:** enganar, negociar, improvisar.
- **Presença:** persuadir, intimidar, liderar.

### Salvamento

- **Sem salvar em qualquer lugar.** O jogo só salva quando o Caelan:
  - **monta acampamento num ponto seguro** do mapa, ou
  - **dorme numa estalagem** numa vila ou na cidade.
- Pontos de acampamento seguros são marcados no mapa ou descobertos explorando. Acampar fora deles é possível (para comer, tratar ferimentos e dormir), mas **não salva** e pode render um evento de emboscada.
- Se o Caelan morre, o jogador volta ao último save.
- **Sugestão técnica:** salvar automaticamente ao fechar o jogo, num save que é apagado ao carregar. Assim o jogador pode sair a qualquer momento sem quebrar a regra.

## Escopo da primeira versão (2 a 4 horas)

**Entra:**
- 1 província de fronteira no mapa de viagem.
- 1 cidade principal pequena: rua principal, taverna/estalagem, mercado, estábulo, curandeiro, sede do poder local.
- 2 ou 3 vilas no estilo faroeste, algumas fazendas e acampamentos.
- 1 ruína ligada à linhagem.
- Trama principal (a pista do símbolo) e algumas missões secundárias.
- Todos os sistemas acima, em versão enxuta.

**Fica de fora (por enquanto):**
- Cavalo.
- Companheiros de grupo.
- Criação de itens além do básico (curativos, flechas simples).
- Dublagem.

## Decisões técnicas

- **Engine:** Godot 4. Desenvolvimento num Mac Apple Silicon, exportação para **Windows, macOS e Linux**.
- **Linguagem:** GDScript.
- **Câmera:** inclinada (45° a 60°), com zoom e rotação limitados.
- **Arte:** assets prontos com licença comercial no início (Synty, Kenney, Fab), animações do Mixamo. Estilo visual a definir.
- **Diálogos:** ferramenta de diálogo em texto (Dialogic, Ink ou Yarn Spinner), a escolher.

## Cuidados legais

O conceito nasceu de um personagem de Baldur's Gate 3 com elementos de O Senhor dos Anéis. Para vender o jogo, **nada desses universos entra**: nomes, lugares, criaturas, linhagens ou termos próprios. Os arquétipos (herdeiro de linhagem caída, ranger andarilho, protetor misterioso) são livres. Todo asset de terceiros precisa permitir uso comercial.

## Questões em aberto

- Nome do jogo, da província, da cidade principal e da dinastia caída.
- Qual é o símbolo dos assassinos e quem está por trás deles.
- Destino real do Caçador.
- Estilo visual: mais realista ou estilizado?
- Quantas vilas e quais facções.
- Companheiros: entram numa versão futura?

## Referências

- **Kingdom Come: Deliverance:** realismo, ferimentos, mundo sem magia.
- **Red Dead Redemption 2:** estrada, acampamento, clima de fronteira.
- **Battle Brothers / The Banner Saga / Oregon Trail:** mapa de viagem e eventos.
- **Disco Elysium:** diálogo como arma, testes de atributo.
- **Darkest Dungeon:** desgaste acumulado entre lutas.
- **Divinity: Original Sin / Baldur's Gate 3:** câmera e combate por turnos.
