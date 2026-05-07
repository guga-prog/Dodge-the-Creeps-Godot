# 🎮 Dodge the Creeps — USPGameDev Training

> 🇧🇷 [Português](#português) | 🇺🇸 [English](#english)

<div align="center">
  <img width="482" height="752" alt="Dodge_The_Creeps" src="https://github.com/user-attachments/assets/01c26f6b-6472-428a-aeb2-81b165aa51cd" />
</div>

---

## English

Modifications to the [Dodge the Creeps](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html) Godot tutorial, developed during the **USPGameDev 2025.2 training program** at USP.

Worked in a team of 3 (1 mentor + 2 collaborators). The base game was provided by the training. All features listed below were my individual contributions.

### Technical Highlights
- **Stage alternation system** — implemented a loop between two distinct game phases 
(coin collection and boss fight) each controlled by an independent timer. 
The boss fight phase was partially implemented — stage transition and timer logic 
were completed but the boss mechanics remained unfinished due to time constraints.
- **Non-uniform spawn distribution** — defined a central rectangle by pixel intervals 
with a higher probability of coin spawning inside it compared to the outer area
- **Coin lifecycle system** — coins spawn on the map, have a limited lifetime, 
disappear automatically and are collected on player contact

### My Contributions
- 🔄 Stage alternation with independent timers (boss fight phase partially implemented)
- 🪙 Coin system with spawn, lifetime, collection and score tracking
- 📍 Non-uniform spawn probability distribution
- 🔊 Player sound effects (spawn, movement, death)
- 📐 Expanded play area via element rescaling

### Built with
- Godot Engine
- GDScript

### About
Developed during USPGameDev's 2025.2 training program at USP.

Original repository: [GitLab](https://gitlab.com/uspgamedev/treinamento/2025-2-corsinha)

---

## Português

Modificações no tutorial [Dodge the Creeps](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html) do Godot, desenvolvidas durante o **treinamento USPGameDev 2025.2** na USP.

Projeto desenvolvido em equipe de 3 pessoas (1 mentor + 2 colaboradores). O jogo base foi fornecido pelo treinamento. Todas as funcionalidades listadas abaixo foram contribuições individuais minhas.

### Destaques Técnicos
- **Sistema de alternância de estágios** — implementei um loop entre duas fases 
distintas do jogo (coleta de moedas e boss fight), cada uma controlada por um 
cronômetro independente. A fase de boss fight foi parcialmente implementada — 
a transição de fases e a lógica do cronômetro foram concluídas, mas a mecânica 
do boss ficou incompleta por limitações de tempo
- **Distribuição de spawn não uniforme** — defini um retângulo central por intervalos 
de pixels com probabilidade maior de spawn de moedas dentro dele em relação à área externa
- **Sistema de ciclo de vida das moedas** — spawn, tempo de vida limitado, 
remoção automática e coleta por contato

### Minhas Contribuições
- 🔄 Alternância de estágios com cronômetros independentes e spawn de boss por fase (fase do boss parcialmente implantada)
- 🪙 Sistema de moedas com spawn, tempo de vida, coleta e pontuação
- 📍 Distribuição de probabilidade não uniforme no spawn
- 🔊 Efeitos sonoros do jogador (nascer, locomover, morrer)
- 📐 Expansão da área útil via reescalamento de elementos

### Tecnologias
- Godot Engine
- GDScript

### Sobre
Desenvolvido durante o treinamento 2025.2 da USPGameDev na USP.

Repositório original: [GitLab](https://gitlab.com/uspgamedev/treinamento/2025-2-corsinha)
