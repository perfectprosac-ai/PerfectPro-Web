# Fabrica Flutter - Matriz de Decisao Tecnica v1

Matriz para acelerar decisoes tecnicas com criterios objetivos na criacao de novos apps.

Data de referencia: 2026-04-20

## 1) Objetivo

- Reduzir decisoes subjetivas.
- Aumentar previsibilidade entre projetos.
- Garantir alinhamento com padrao da Fabrica Flutter PerfectPro.

## 2) Como usar esta matriz

Para cada eixo de decisao:

1. Avaliar contexto do app.
2. Aplicar criterios obrigatorios.
3. Selecionar opcao recomendada.
4. Registrar justificativa em `docs/arquitetura.md`.

## 3) Persistencia local: Isar vs Drift (SQLite)

### Quando escolher Isar (preferencial para velocidade de entrega)

Use Isar se:

- Modelo de dados orientado a objetos.
- Necessidade de alto desempenho local.
- Baixa necessidade de SQL complexo.
- Time quer produtividade com menos boilerplate.

Evitar Isar quando:

- Houver dependencia forte de consultas SQL customizadas.

### Quando escolher Drift (SQLite)

Use Drift se:

- Regras exigem consultas relacionais complexas.
- Necessidade de SQL previsivel e auditavel.
- Time tem dominio de modelagem relacional.

Evitar Drift quando:

- Velocidade inicial de desenvolvimento for prioridade extrema e consultas forem simples.

### Regra de decisao rapida

- CRUD offline simples/moderado -> Isar.
- Relatorios e consultas relacionais pesadas -> Drift.

## 4) Estado e DI: Riverpod vs GetIt

### Riverpod (padrao preferencial)

Escolher Riverpod se:

- App exige rastreabilidade de estado.
- Necessidade de testes mais robustos de estado.
- Time quer unificar estado + DI no mesmo ecossistema.

### GetIt (uso complementar ou legado)

Escolher GetIt se:

- Projeto legado ja usa GetIt amplamente.
- Necessidade principal e apenas localizacao de dependencias.

Regra:

- Novo projeto -> Riverpod como padrao.
- Projeto legado -> manter GetIt onde ja estabilizado e migrar gradualmente se necessario.

## 5) CI/CD: Codemagic vs GitHub Actions

### Codemagic (preferencial para mobile-first)

Escolher Codemagic se:

- Time quer setup mais rapido para mobile.
- Necessidade de signing e distribuicao simplificados.
- Foco principal em apps Flutter mobile.

### GitHub Actions (preferencial para flexibilidade)

Escolher GitHub Actions se:

- Time precisa pipelines altamente customizadas.
- Ja existe governanca forte no GitHub.
- Integracoes multiplas fora do mobile sao relevantes.

Regra:

- Operacao pequena/media com foco mobile -> Codemagic.
- Operacao com forte ecossistema GitHub e automacoes amplas -> GitHub Actions.

## 6) Arquitetura: Camada minima vs Expandida por feature

### Camada minima (`core/data/utils/screens`)

Escolher quando:

- MVP ou escopo inicial curto.
- Equipe pequena.
- Dominio ainda em descoberta.

### Expandida por feature (`features/*` + domain)

Escolher quando:

- Produto com crescimento continuo.
- Multiplos modulos de negocio.
- Necessidade de escalar equipe e manutencao.

Regra:

- Iniciar simples, migrar para expandida ao atingir complexidade moderada.

## 7) Integracao nativa: MethodChannel ou plugin pronto

### Plugin pronto (preferencial)

Escolher quando:

- Plugin confiavel cobre 100% do caso de uso.
- Reduz risco de manutencao nativa.

### MethodChannel (quando necessario)

Escolher quando:

- Requisito nao coberto por plugin.
- Necessidade de comportamento especifico de plataforma.

Regra:

- Priorizar plugin pronto; usar MethodChannel apenas com justificativa tecnica clara.

## 8) Engenharia de PDF: nivel padrao vs nivel avancado

### Nivel padrao

Aplicar quando:

- PDF simples, sem layout critico.
- Baixa variabilidade de dados.

### Nivel avancado (recomendado para apps vendaveis)

Aplicar quando:

- Documento e parte critica do produto.
- Necessidade de consistencia visual alta.
- Exigencia de compatibilidade de caracteres e impressao.

Requisitos do nivel avancado:

- `pdf` + `printing`
- Fontes `.ttf` embarcadas
- Sanitizacao Unicode/fallback ASCII
- Testes em dispositivo real

## 9) Billing/IAP: incluir desde inicio ou sob demanda

Incluir desde inicio se:

- Modelo de negocio depende de assinatura/compra.
- Fluxo de receita precisa ser validado cedo.

Postergar se:

- MVP de validacao ainda sem monetizacao ativa.

Regra:

- Se monetizacao e core, IAP entra no primeiro ciclo de arquitetura.

## 10) Observabilidade: basica vs completa

### Basica

- Logs estruturados.
- Captura de erros.

### Completa (recomendada para producao comercial)

- Crash analytics com alertas.
- Monitoramento de performance.
- Dashboard por versao/release.

Regra:

- Todo app comercial deve sair com observabilidade completa.

## 11) Matriz resumida (decisao rapida)

| Eixo | Opcao A | Opcao B | Escolha padrao |
|---|---|---|---|
| Persistencia local | Isar | Drift | Isar (se SQL complexo nao for requisito) |
| Estado/DI | Riverpod | GetIt | Riverpod |
| CI/CD | Codemagic | GitHub Actions | Contextual (mobile-first: Codemagic) |
| Arquitetura | Minima | Expandida por feature | Evolutiva (inicia minima) |
| Integracao nativa | Plugin pronto | MethodChannel | Plugin pronto |
| PDF | Padrao | Avancado | Avancado (app comercial) |
| Observabilidade | Basica | Completa | Completa |

## 12) Regras de excecao

Uma excecao ao padrao so e aceita se:

- Estiver documentada em `docs/arquitetura.md`.
- Tiver justificativa tecnica e de negocio.
- Tiver avaliacao de risco e plano de mitigacao.

## 13) Registro final padrao

Ao concluir a decisao de stack do app:

- O que foi decidido (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

---

Status: matriz de decisao tecnica v1 pronta para uso na Fabrica Flutter.
