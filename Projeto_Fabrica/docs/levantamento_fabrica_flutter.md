# Fabrica Flutter - Especificacao Base v1

Objetivo: consolidar os requisitos para criar uma estrutura padrao de desenvolvimento de apps Flutter com foco em qualidade, previsibilidade, seguranca e escala comercial.

Data: 2026-04-20

## 1) Visao da Fabrica

- Nome da fabrica: Fabrica Flutter PerfectPro
- Meta principal: produzir apps comercializaveis com padrao tecnico superior e baixo retrabalho.
- Escopo inicial: Android, iOS e Web (opcional por produto).
- Nivel de entrega esperado: pronto para loja + operacao sustentada.

## 2) Stack Tecnica Alvo (oficial)

Base obrigatoria:

- Dart SDK: linha estavel 3.x com Null Safety total.
- Flutter SDK: canal `stable`.
- Gestao de versao do Flutter: FVM obrigatorio em desenvolvimento e CI.

Stack nativo:

- Android nativo: Kotlin.
- iOS nativo: Swift.
- Build Android: Gradle Kotlin DSL (`.gradle.kts`).

Ferramentas de build e plataforma (fixar por projeto):

- Android Gradle Plugin: versao definida no bootstrap do app.
- Kotlin: versao definida no bootstrap do app.
- Java: versao definida no bootstrap do app.
- Xcode: versao definida no bootstrap do app.
- iOS deployment target: versao definida no bootstrap do app.

Dependencias padrao (base recomendada):

- Gerenciamento de estado: Riverpod (preferencial).
- Roteamento: GoRouter (preferencial).
- Injecao de dependencia: GetIt ou Riverpod.
- Persistencia local: Isar ou Drift (SQLite), conforme complexidade.
- HTTP client: Dio.
- Serializacao: json_serializable + build_runner.
- Logging: logger (com adaptador para crash analytics).
- Crash analytics: Firebase Crashlytics ou equivalente.
- Feature flags: Remote Config ou provedor dedicado.

## 3) Arquitetura Padrao

Modelo de camadas obrigatorio:

- `lib/core` (config, erros, utilitarios, tema)
- `lib/data` (repositorios e fontes de dados)
- `lib/utils` (validadores e tratamentos de texto, ex.: PDF safe text)
- `lib/screens` (camada de interface)

Modelo expandido para apps maiores:

- `lib/features/<feature>/data`
- `lib/features/<feature>/domain`
- `lib/features/<feature>/presentation`
- `lib/services` (servicos transversais)
- `lib/shared` (componentes reutilizaveis)

Decisoes padrao:

- Padrao arquitetural final: Hibrido (Modular + principios de Clean onde houver regra critica).
- Convencao de nomes: `snake_case` para arquivos, sufixos descritivos por papel (`_screen`, `_service`, `_repository`).
- Padrao de pastas por feature: obrigatorio em produtos de medio/grande porte.
- Contratos de services: interfaces claras para facilitar testes e troca de implementacao.

## 4) Componentes Nativos Android (core tecnico)

Obrigatorios para a fabrica:

- Gradle Kotlin DSL em todos os projetos Android.
- Dominar MethodChannel para recursos nativos nao cobertos pelo Flutter.
- Configurar ProGuard/R8 para ofuscacao e reducao de superficie de engenharia reversa.
- Garantir coerencia entre `namespace`, `applicationId` e pacote Kotlin.

## 5) Engenharia de Documentos (diferencial)

Padrao oficial para PDF:

- `pdf` package para composicao de documentos.
- `printing` package para compartilhamento/impressao (`Printing.sharePdf`).
- Fontes `.ttf` embarcadas declaradas no `pubspec.yaml` para consistencia visual.
- Sanitizacao de texto para Unicode e fallback ASCII quando necessario.
- Validacao de PDF em cenarios reais (acentos, simbolos, bullets, campos compostos).

## 6) Qualidade e Governanca

Checklist base da fabrica:

- Analise estatica: `flutter analyze`
- Formatacao: `dart format`
- Testes unitarios: obrigatorio para regras de negocio.
- Testes de widget: obrigatorio para telas criticas.
- Testes de integracao: obrigatorio para fluxos de venda/pagamento e onboarding.
- Cobertura minima (%): 70% no minimo para modulos criticos.
- Politica de branches: `main` protegida + branches de feature/hotfix.
- Politica de commit: atomicos e rastreaveis por escopo.
- Definition of Done: build, testes, lint, revisao, checklist de release e evidencias.

## 7) Seguranca e Segredos

- Estrategia de `.env` por ambiente: `dev`, `hml`, `prod`.
- Armazenamento seguro de chaves: cofre de segredos no CI.
- Segredos fora do repositorio: obrigatorio.
- Modelo de `key.properties.example`: obrigatorio para onboarding.
- Revisao de permissoes por plataforma: obrigatoria antes de release.

Keystore management:

- Processo rigoroso de criacao e custodia de `.jks`.
- `key.properties` local e nunca versionado.
- Rotacao e backup seguro das chaves de release.

## 8) Publicacao e Compliance

Android (Play Console):

- Namespace/applicationId por app:
- Data Safety:
- Billing (quando aplicavel) com `in_app_purchase` e Play Billing Library 5.0+:
- Politica de privacidade publica:

iOS (App Store):

- Bundle ID:
- Privacidade e permissoes:
- Provisioning e signing:

## 9) Observabilidade e Operacao

- Padrao de logs: estruturado por feature e nivel.
- Monitoramento de erros: Crashlytics ou equivalente com alertas ativos.
- Monitoramento de performance: tempo de inicializacao e latencia de fluxos criticos.
- Alertas de regressao: painel com falhas por versao.
- Rotina de pos-release: verificacao de crashes, reviews e funil de uso.

## 10) Pipeline de Entrega (CI/CD)

Definir pipeline minimo:

1. Lint e analise estatica
2. Testes automatizados
3. Build por ambiente
4. Assinatura
5. Publicacao interna
6. Checklist manual final

Ferramenta de CI alvo:

- Codemagic ou GitHub Actions (padrao recomendado da fabrica).
- Pipeline deve fixar versao do Flutter via FVM.

## 11) Catalogo de Templates da Fabrica

Templates iniciais sugeridos:

- App padrao CRUD offline-first
- App com autenticacao + perfil
- App com assinatura/billing
- App com emissao de PDF
- App com painel administrativo web

## 12) Resumo do Stack Ideal

| Componente | Tecnologia |
|---|---|
| Linguagem | Dart 3+ |
| Framework | Flutter stable (com FVM) |
| Nativo Android | Kotlin |
| Nativo iOS | Swift |
| Banco de dados local | Isar ou Drift (SQLite) |
| Injeção de dependencia | GetIt ou Riverpod |
| Geração de PDF | `pdf` + `printing` |

## 13) Criticos para Decisao (proximos passos)

Antes da implementacao da fabrica, confirmar:

1. Versoes oficiais da stack (Flutter/Dart e build tools)
2. Arquitetura padrao obrigatoria
3. Kit minimo de dependencias aprovadas
4. Esteira CI/CD oficial
5. Checklist de release oficial por plataforma

---

Status atual: especificacao base consolidada com diretrizes obrigatorias e pronta para virar padrao operacional da Fabrica Flutter.
