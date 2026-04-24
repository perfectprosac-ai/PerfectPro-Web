# Arquitetura do App - Template

Documento de referencia arquitetural para apps da Fabrica Flutter.

Data de criacao: 2026-04-20

## 1) Visao geral

- Nome do app:
- Objetivo de negocio:
- Plataformas alvo:
- Escopo funcional inicial:

## 2) Stack oficial

- Flutter:
- Dart:
- Android: Kotlin + Gradle Kotlin DSL
- iOS: Swift
- Gerenciamento de estado:
- Roteamento:
- Injeção de dependencia:
- Banco local:
- HTTP client:
- PDF:

## 3) Estrutura de camadas

Estrutura minima:

- `lib/core`
- `lib/data`
- `lib/utils`
- `lib/screens`

Estrutura expandida:

- `lib/features/<feature>/data`
- `lib/features/<feature>/domain`
- `lib/features/<feature>/presentation`
- `lib/services`
- `lib/shared`

## 4) Decisoes arquiteturais

### 4.1 Padrao adotado

- Arquitetura: Hibrida (Modular + principios de Clean)
- Justificativa:

### 4.2 Convencoes

- Nomes de arquivo: `snake_case`
- Sufixos:
  - `_screen`
  - `_service`
  - `_repository`
  - `_model`

### 4.3 Contratos

- Interfaces de repositorio definidas em:
- Interfaces de service definidas em:
- Politica de tratamento de erro:

## 5) Dados e persistencia

- Banco local escolhido:
- Estrategia offline-first:
- Estrategia de migracao de schema:
- Politica de backup/restauracao (se aplicavel):

## 6) Integracoes nativas

- MethodChannels necessarios:
- Objetivo de cada canal:
- Plano de fallback:

## 7) Seguranca

- Segredos por ambiente (`dev`/`hml`/`prod`):
- Keystore management:
- Politica de permissoes:
- Politica de logs sensiveis:

## 8) Engenharia de PDF (quando aplicavel)

- Fontes embarcadas:
- Regras de sanitizacao de texto:
- Estrategia de template de documento:
- Fluxo de share/print:

## 9) Qualidade e testes

- Lint/format:
- Testes unitarios:
- Testes de widget:
- Testes de integracao:
- Cobertura minima:

## 10) CI/CD

- Ferramenta:
- Etapas da pipeline:
- Criterios de aprovacao:

## 11) Riscos tecnicos e mitigacoes

- Risco 1:
  - Mitigacao:
- Risco 2:
  - Mitigacao:

## 12) Historico de decisoes (ADR simplificado)

- [DATA] Decisao:
  - Contexto:
  - Decisao:
  - Consequencia:

---

Status: template de arquitetura pronto para preenchimento por projeto.
