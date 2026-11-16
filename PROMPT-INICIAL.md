# Prompts prontos

Cole na IA de código (Claude Code, Codex, Cursor), aberta na pasta do projeto, com o kit já copiado para `docs/kit/`.
Troque o que está entre `< >`. Não cole chave, senha nem token em nenhum deles.

## Prompt 1. Primeiro dia de um projeto novo

```text
Vamos construir <o que é, em uma linha>. Antes de escrever qualquer código:

1. Leia inteiros docs/kit/MANUAL-CONSTRUCAO.md, docs/kit/CICLO-DA-TAREFA.md e docs/kit/POKA-YOKE-DIGITAL.md.
2. As cinco linhas do P0 que eu já tenho:
   - quem usa: <...>
   - problema que resolve: <...>
   - dado que entra: <...>
   - nível que eu acho: <N1, N2 ou N3>
   - prazo: <...>
   Diga em qual nível você classifica o projeto e por quê, e me pergunte o que faltar do P0.
3. Com o P0 aprovado por mim, siga P1 a P6 em ordem, um passo por vez: entregue o que o passo pede, rode a prova
   dele, me mostre a saída e espere meu OK antes do próximo.
4. Use docs/kit/modelos como base do primeiro commit (AGENTS.md, CLAUDE.md, CONTEXTO.md, docs/PROJETO.md,
   .gitignore, .env.example, .npmrc, .github/workflows/ci.yml, .claude/settings.json,
   supabase/tests/rls_ligada.test.sql, scripts/alvo.mjs e o teste dela).
5. Regra de negócio que não está escrita não é sua para decidir: anote na seção Pendências do docs/PROJETO.md e me
   pergunte. O que você escolher sozinho porque o pedido não dizia vai para a seção Suposições, para eu confirmar.
6. Nunca me peça chave, senha ou token no chat. Diga em qual arquivo ou painel eu coloco.

Comece pelo item 1 e me responda o item 2.
```

## Prompt 2. Cada tarefa nova

```text
Tarefa: <o que precisa mudar, para quem, e como eu sei que deu certo>.

Siga o docs/kit/CICLO-DA-TAREFA.md: leia o código que a tarefa toca antes de planejar e me mostre o plano com os
arquivos exatos e o teste. Depois de construir, rode `npm run check` e me mostre a saída. Tela nova ou mudada passa
pelo checklist da seção 6 do docs/kit/POKA-YOKE-DIGITAL.md. Se for bug, escreva antes como está, como deveria ser e o
que não pode mudar, cada um com teste. Mudança de banco, login, permissão ou dinheiro vai por PR.
Não diga "pronto" sem a prova do P8 do manual, e atualize o CONTEXTO.md no fim.
```

## Prompt 3. Projeto que já existe

```text
Este projeto já existe e não quero mudança de código agora. Leia docs/kit/MANUAL-CONSTRUCAO.md e depois o código.
Me entregue uma tabela: passo do manual (P2 a P10) | tem, em parte ou falta | prova (arquivo e linha, ou o comando
que você rodou e a saída). Só leitura: nada de gravar no banco nem de publicar. Falta que expõe dado ou segredo vai
para o topo. Depois eu decido o que consertar primeiro.
```

## Prompt 4. Revisão por outra IA

Use uma IA diferente da que construiu, de preferência de outra família, numa conversa nova. Cole o plano ou o diff
(`git diff main...<branch>`) logo abaixo do prompt.

```text
Revise este <plano | diff> como quem não construiu. Para cada problema: arquivo e linha, o que quebra e o cenário
concreto que mostra a falha (entrada, estado, resultado errado). Olhe em especial segurança (login e papel conferidos
no servidor, RLS, segredo), perda de dado, regra de negócio inventada e teste que não testa nada. Não reescreva o
código e não liste gosto pessoal. Termine com uma palavra: APROVADO ou REVISAR.
```

Revisão de segurança voltando com muito ruído? Acrescente ao prompt: "Liste só o achado que você acha explorável; antes
de listar, tente provar que ele é falso positivo e diga por que não é."

Com REVISAR, leve os achados para a IA que construiu, decida cada um (aceita ou recusa com motivo) e mande de novo ao
mesmo revisor. Resposta vazia ou com erro não é aprovação.

Meça o revisor de vez em quando: conte quantas vezes ele aprovou um diff em que outra revisão achou defeito real.
Revisor que aprova quase tudo não é segunda opinião (manual, P12).

## Prompt 5. Auditoria final antes de entregar

Antes de uma apresentação, do MVP ou do início do uso real (manual, P8, "Antes de uma entrega"). Use o modelo mais
forte que você tiver, numa conversa nova. Em modelo novo, prompt cheio de passos piora o resultado. Dê o objetivo, o
contexto e os limites, como abaixo.

```text
Você vai fazer a última análise deste sistema antes da entrega de <data>. Leia docs/kit/MANUAL-CONSTRUCAO.md (P8,
"Antes de uma entrega"), docs/PROJETO.md, AGENTS.md e CONTEXTO.md, e monte o seu mapa do sistema.

Olhe o sistema inteiro, não uma mudança: regra de negócio nas bordas; segurança (RLS, papel conferido no servidor,
sessão, segredo); dados (gravação dupla, concorrência, falha parcial); mensagens (causa e quem resolve); telas (a tela
de entrada responde à pergunta principal em 10 segundos? 360 px, texto a 200%, número cru, frase que contradiz a
coluna ao lado, valor sugerido que o "só confirmar" torna falso); e o que falta contra o PROJETO. Use o site no ar com
as contas de teste de cada perfil, e o código.

Para cada achado: arquivo e linha ou o passo para reproduzir, a saída errada e a certa. Sem prova, não entra.
Classifique em: bloqueia a entrega, bloqueia a próxima, melhoria. Grave em docs/auditoria-<data>.md.

Pode fazer sem pedir: ler tudo, rodar teste e build, criar branch seu e consertar defeito com teste. Precisa do meu
OK: gravar no banco de produção, aplicar migration, publicar e mudar regra de negócio. A regra você descreve com um
exemplo numérico e me pergunta.

Use agentes para as varreduras de leitura, cada um sem o seu contexto, e guarde o seu julgamento para segurança,
regra e síntese. Siga até terminar: erro ou tempo esgotado se contorna, não para o trabalho. Feche com um resumo que
se entenda sozinho: o que achou, o que consertou, o que fica para eu decidir e em que ordem atacar o resto.
```
