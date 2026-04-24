# Fabrica Flutter - Governanca de Engenharia v1

Diretrizes de governanca para desenvolvimento, revisao e release dos apps da Fabrica Flutter PerfectPro.

Data de referencia: 2026-04-20

## 1) Objetivo

- Garantir previsibilidade e qualidade tecnica nas entregas.
- Reduzir risco operacional em producao.
- Padronizar colaboracao entre engenharia, produto e QA.
- Manter rastreabilidade ponta a ponta de mudancas.

## 2) Modelo de branch

Branches oficiais:

- `main`: codigo estavel e pronto para producao.
- `develop` (opcional): consolidacao continua em times maiores.
- `feature/*`: novas funcionalidades.
- `bugfix/*`: correcoes sem urgencia critica.
- `hotfix/*`: correcoes urgentes em producao.
- `release/*`: preparacao de versao para loja.

Regras:

- Nao commitar diretamente em `main`.
- Toda alteracao deve passar por Pull Request.
- Branches devem ser pequenas e focadas em um objetivo.

## 3) Politica de commits

Padrao recomendado:

- Commits atomicos (um objetivo por commit).
- Mensagens claras com foco no "por que".
- Evitar commits gigantes com escopos mistos.

Convencao sugerida:

- `feat:` nova funcionalidade
- `fix:` correcao de defeito
- `refactor:` melhoria estrutural sem alterar regra funcional
- `test:` testes
- `docs:` documentacao
- `chore:` manutencao tecnica

## 4) Politica de Pull Request (PR)

Tamanho ideal:

- Ate 400 linhas alteradas (quando possivel).

Conteudo obrigatorio do PR:

- Contexto do problema ou objetivo.
- Escopo da mudanca.
- Impacto esperado.
- Evidencias de validacao (logs, prints, videos, relatorios).
- Checklist de qualidade preenchido.

Checklist minimo no PR:

- [ ] Build local sem erro
- [ ] `flutter analyze` OK
- [ ] `flutter test` OK
- [ ] Fluxo principal validado
- [ ] Sem segredos no diff
- [ ] Documentacao atualizada (quando aplicavel)

## 5) Regras de code review

Foco principal do review:

1. Risco de regressao funcional
2. Integridade da arquitetura
3. Seguranca e exposicao de dados
4. Performance e escalabilidade
5. Legibilidade e manutencao

Criterios de bloqueio:

- Quebra de fluxo critico.
- Falha de build/lint/test.
- Exposicao de segredo ou dado sensivel.
- Mudanca fora de escopo sem justificativa.
- Ausencia de validacao minima.

Aprovacao minima:

- 1 aprovacao tecnica para mudancas pequenas.
- 2 aprovacoes para mudancas criticas (billing, auth, persistencia, release).

## 6) Quality gates obrigatorios

Antes de merge:

- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- Validacao manual de fluxo impactado

Para mudancas criticas:

- Teste de integracao do fluxo.
- Validacao em dispositivo fisico.
- Revisao adicional de seguranca.

## 7) Controle de seguranca

Regras mandatórias:

- Nunca versionar segredos reais.
- `android/key.properties` sempre local.
- Keystore `.jks` sob custodia segura.
- Revisao de permissoes Android/iOS por release.
- Politica de privacidade atualizada antes de publicar.

## 8) Governanca de release

Fluxo:

1. Criar branch `release/*`
2. Rodar checklist de release completo
3. Gerar artefatos assinados
4. Publicar em internal testing / staged rollout
5. Monitorar 48h
6. Promover release estavel

Criterio para bloquear release:

- Crash critico nao resolvido
- Regressao em fluxo de receita (ex.: pagamento)
- Nao conformidade com requisitos da loja

## 9) Gestao de incidentes (hotfix)

Quando houver incidente em producao:

- Criar branch `hotfix/*`.
- Corrigir apenas o necessario para estabilizar.
- Validar build + fluxo impactado.
- Publicar correção em prioridade.
- Fazer post-mortem tecnico com causa raiz e prevencao.

## 10) Rastreabilidade obrigatoria

Toda entrega deve registrar:

- Ticket/epic relacionado (quando existir).
- PR correspondente.
- Versao impactada.
- Risco identificado.
- Evidencia de validacao.
- Resultado final (OK/ERRO).

## 11) Definition of Done (DoD) de governanca

Uma entrega so pode ser considerada concluida quando:

- Passou por PR e code review.
- Atendeu quality gates.
- Nao possui segredo exposto.
- Teve validacao funcional documentada.
- Possui rastreabilidade minima registrada.

## 12) Ritual operacional recomendado

- Daily tecnico rapido.
- Revisao semanal de risco tecnico.
- Revisao quinzenal de backlog tecnico.
- Retrospectiva de release mensal.

## 13) Formato de registro final padrao

Usar sempre:

- O que foi feito (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

---

Status: governanca de engenharia v1 pronta para adocao na Fabrica Flutter.
