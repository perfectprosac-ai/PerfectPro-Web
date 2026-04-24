# Fabrica Flutter - Roadmap de Implantacao (30/60/90)

Plano de implantacao progressiva da Fabrica Flutter PerfectPro para transformar padroes em operacao real.

Data de referencia: 2026-04-20

## 1) Objetivo do roadmap

- Implantar a fabrica com risco controlado.
- Estabelecer governanca, qualidade e previsibilidade.
- Atingir capacidade de entrega repetivel para apps comercializaveis.

## 2) Metas globais de sucesso

Ao final de 90 dias:

- 100% dos novos apps iniciados com template oficial.
- 100% das releases usando checklist de release.
- 100% dos PRs seguindo gates minimos de qualidade.
- Reducao de retrabalho tecnico em pelo menos 30%.
- Tempo medio de bootstrap de novo app reduzido para ate 1 dia util.

## 3) Fase 1 - Primeiros 30 dias (Fundacao)

### Objetivo

Consolidar padroes e deixar o kit da fabrica pronto para uso obrigatorio.

### Entregaveis

- `docs/padrao_de_app.md`
- `docs/levantamento_fabrica_flutter.md`
- `docs/fabrica_flutter_playbook.md`
- `docs/fabrica_flutter_bootstrap_checklist.md`
- `docs/fabrica_flutter_template_manifest.md`
- `docs/release_checklist.md`
- `docs/arquitetura.md`
- `docs/changelog.md`
- `docs/fabrica_flutter_governanca.md`
- `docs/fabrica_flutter_matriz_decisao.md`

### Acoes praticas

- Definir stack oficial (Flutter/Dart/Kotlin/AGP/Java/Xcode).
- Publicar regra: FVM obrigatorio em dev e CI.
- Definir padrao de branch, PR e review.
- Definir pipeline minima oficial (Codemagic ou GitHub Actions).
- Criar um projeto piloto usando o template manifest.

### KPIs da fase

- Kit documental completo: 100%.
- Projeto piloto criado com sucesso: 1.
- Tempo de bootstrap medido e registrado.

### Riscos e mitigacoes

- Risco: adesao parcial ao padrao.
  - Mitigacao: gate de PR exigindo checklist obrigatorio.
- Risco: divergencia de versoes entre ambientes.
  - Mitigacao: pinagem via FVM e validacao no CI.

## 4) Fase 2 - 31 a 60 dias (Padronizacao operacional)

### Objetivo

Converter padroes em rotina de equipe e qualidade previsivel de entrega.

### Entregaveis

- Pipeline CI/CD ativa para projeto piloto.
- DoD de engenharia em uso real.
- Processo de release executado fim a fim em ambiente interno.
- Matriz de decisao aplicada em pelo menos 2 decisoes reais.

### Acoes praticas

- Exigir `flutter analyze` + `flutter test` como bloqueio de merge.
- Implantar template de PR com checklist padrao.
- Rodar primeira release interna usando `docs/release_checklist.md`.
- Validar engenharia de PDF em dispositivo real.
- Executar simulacao de hotfix com fluxo `hotfix/*`.

### KPIs da fase

- Taxa de PR com checklist completo >= 90%.
- Taxa de pipeline verde >= 85%.
- Tempo medio de review reduzido.
- Zero incidente de segredo exposto em commit.

### Riscos e mitigacoes

- Risco: PRs grandes dificultando review.
  - Mitigacao: limite orientativo de tamanho e splitting por escopo.
- Risco: falhas recorrentes de pipeline.
  - Mitigacao: hardening da pipeline + correcoes no template base.

## 5) Fase 3 - 61 a 90 dias (Escala e melhoria continua)

### Objetivo

Escalar a fabrica com foco em estabilidade, observabilidade e produtividade.

### Entregaveis

- 2+ apps ou modulos iniciados no template oficial.
- Dashboard de qualidade/release com indicadores basicos.
- Ritual mensal de retrospectiva de release instituido.
- Backlog tecnico da fabrica priorizado por impacto.

### Acoes praticas

- Consolidar monitoramento pos-release (crashes, ANRs, performance).
- Aplicar matriz de decisao como artefato obrigatorio na arquitetura.
- Revisar e atualizar templates com base em licoes aprendidas.
- Definir plano de evolucao v2 da fabrica (automacoes extras, kits por tipo de app).

### KPIs da fase

- Conformidade do template nos novos projetos: 100%.
- Regressao critica por release: <= 1.
- Tempo medio de release reduzido em comparacao ao baseline.
- Reuso de componentes/shared aumentando a cada ciclo.

### Riscos e mitigacoes

- Risco: crescimento de complexidade sem evolucao de arquitetura.
  - Mitigacao: revisao quinzenal de arquitetura e debt tecnico.
- Risco: baixa observabilidade em producao.
  - Mitigacao: obrigatoriedade de stack completa de observabilidade em app comercial.

## 6) Ritos de governanca recomendados

- Daily tecnico curto (15 min).
- Revisao semanal de risco tecnico.
- Comite quinzenal de arquitetura.
- Revisao mensal de indicadores de release.

## 7) Indicadores de acompanhamento (painel minimo)

- Lead time de feature (inicio -> merge -> release).
- Taxa de sucesso de pipeline.
- Taxa de rollback/hotfix por release.
- Defeitos pos-release por severidade.
- Tempo de resolucao de incidentes.

## 8) Critérios de aceite da implantacao

Implantacao considerada bem-sucedida quando:

- Processos definidos estao em uso recorrente.
- Times usam os templates sem friccao relevante.
- Releases seguem quality gates e checklist oficial.
- Existe reducao mensuravel de falhas e retrabalho.

## 9) Proximos passos apos 90 dias

- Evoluir para Fabrica Flutter v2.
- Automatizar geracao de projeto por script/CLI interno.
- Criar catalogo de blueprints por vertical de negocio.
- Integrar metricas da fabrica com objetivos de produto.

## 10) Registro final padrao

Ao concluir cada fase, registrar:

- O que foi feito (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

---

Status: roadmap de implantacao 30/60/90 pronto para execucao.
