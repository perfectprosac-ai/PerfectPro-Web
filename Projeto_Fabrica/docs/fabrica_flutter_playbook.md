# Fabrica Flutter - Playbook Operacional v1

Guia operacional para executar projetos Flutter com previsibilidade, seguranca e rastreabilidade.

Data de referencia: 2026-04-20

## 1) Objetivo

- Padronizar a execucao tecnica de ponta a ponta.
- Reduzir risco de regressao e retrabalho.
- Garantir prontidao de publicacao (Play Store / App Store).
- Tornar o processo repetivel para equipe.

## 2) Fluxo mestre da Fabrica

1. Bootstrap tecnico do projeto
2. Implementacao por ciclos curtos
3. Validacao continua de qualidade
4. Preparacao de release
5. Publicacao controlada
6. Operacao e monitoramento pos-release

## 3) Fase 1 - Bootstrap tecnico

Checklist obrigatorio:

- Definir versoes oficiais no projeto:
  - Flutter (stable) via FVM
  - Dart 3+ (Null Safety total)
  - Kotlin / AGP / Java
  - Xcode / iOS deployment target
- Estruturar pastas base:
  - `lib/core`
  - `lib/data`
  - `lib/utils`
  - `lib/screens`
- Definir arquitetura expandida para apps maiores:
  - `lib/features/<feature>/{data,domain,presentation}`
  - `lib/services`
  - `lib/shared`
- Configurar lint, formatacao e regras de qualidade.
- Criar arquivos de exemplo de ambiente e segredos:
  - `.env.example`
  - `android/key.properties.example`
- Revisar `.gitignore` para bloquear chaves e artefatos sensiveis.

Gate de saida da fase:

- Projeto compila em debug para Android e iOS.
- Estrutura de pastas aprovada.
- Ferramentas de qualidade configuradas.

## 4) Fase 2 - Implementacao controlada

Regra operacional por tarefa:

1. Identificar arquivo alvo.
2. Ler conteudo completo.
3. Diagnostico rapido (problema/melhoria + impacto).
4. Plano de intervencao (correcao/refatoracao/implementacao/validacao).
5. Aplicar alteracao minima necessaria.
6. Validar localmente.
7. Registrar status final.

Modos de execucao:

- Modo Erro:
  - Localizar causa raiz.
  - Corrigir diretamente.
  - Nao alterar escopo nao relacionado.
- Modo Implementacao:
  - Seguir padrao de projeto.
  - Garantir compatibilidade offline (Isar ou Drift/SQLite).
  - Integrar via services com contratos claros.
- Modo Validacao:
  - Validar build, fluxo, dados locais e documentos.

Gate de saida da fase:

- Alteracao funcional concluida.
- Sem regressao aparente no fluxo relacionado.

## 5) Fase 3 - Qualidade continua

Checklist tecnico minimo por ciclo:

- `dart format .`
- `flutter analyze`
- `flutter test`

Checklist recomendado para fluxo critico:

- Testes de widget para telas principais.
- Testes de integracao para onboarding, login e pagamento.
- Cobertura minima de 70% em modulos criticos.

Gate de saida da fase:

- Lint e testes sem erro.
- Evidencias de validacao anexadas ao registro da tarefa.

## 6) Fase 4 - Engenharia de documentos (PDF)

Padrao obrigatorio:

- Uso de `pdf` para composicao.
- Uso de `printing` para compartilhar/imprimir.
- Fontes `.ttf` embarcadas no `pubspec.yaml`.
- Sanitizacao de texto para Unicode e fallback seguro.

Checklist de validacao de PDF:

- Acentos e caracteres especiais renderizam corretamente.
- Bullets e separadores visuais consistentes.
- Campos compostos usam formato padronizado (ASCII seguro quando necessario).
- Compartilhamento via `Printing.sharePdf` funcional.

Gate de saida da fase:

- PDF abre, renderiza e compartilha em dispositivo real.

## 7) Fase 5 - Seguranca e segredos

Checklist obrigatorio:

- Nenhum segredo commitado.
- `key.properties` apenas local.
- Keystore `.jks` sob custodia segura.
- Permissoes Android/iOS revisadas por necessidade real.
- Data Safety e politica de privacidade atualizadas.

Gate de saida da fase:

- Projeto apto para auditoria de seguranca basica.

## 8) Fase 6 - CI/CD e release

Pipeline minimo (Codemagic ou GitHub Actions):

1. Resolver dependencias
2. Lint e analise estatica
3. Testes automatizados
4. Build Android (`.aab`) e iOS (quando aplicavel)
5. Assinatura e artefatos de release
6. Publicacao interna para validacao final

Checklist pre-publicacao:

- `namespace`, `applicationId` e bundle id coerentes.
- Versionamento (`versionName`/`versionCode`) atualizado.
- Billing validado (se houver IAP).
- Politica de privacidade publicada e acessivel.
- Build final validado em dispositivo fisico.

Gate de saida da fase:

- Artefatos prontos para submissao nas lojas.

## 9) Fase 7 - Pos-release e operacao

Nas primeiras 48h:

- Monitorar crashes e ANRs.
- Acompanhar performance de inicializacao.
- Verificar funil de uso dos fluxos principais.
- Registrar feedbacks criticos de usuarios/testadores.

Rotina semanal:

- Revisar taxa de falha por versao.
- Priorizar hotfixes por severidade.
- Atualizar backlog tecnico da fabrica.

Gate de saida da fase:

- Release estabilizado sem incidente critico aberto.

## 10) Definition of Done (DoD) da Fabrica

Uma entrega so e considerada concluida quando:

- Build local concluido sem erro.
- Lint e testes obrigatorios aprovados.
- Fluxo principal validado manualmente.
- Persistencia local integra (quando aplicavel).
- PDF validado (quando aplicavel).
- Seguranca basica revisada.
- Registro final publicado no formato padrao.

## 11) Formato padrao de registro final

Usar sempre:

- O que foi feito (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

## 12) Matriz de responsabilidades (sugerida)

- Engenharia:
  - Arquitetura, implementacao, testes e release tecnico.
- Produto:
  - Priorizacao, escopo e criterios de aceite.
- QA:
  - Validacao funcional e regressao.
- Operacao:
  - Monitoramento, incidentes e melhoria continua.

## 13) Templates minimos de projeto da Fabrica

- Template A: CRUD offline-first.
- Template B: autenticacao + perfil.
- Template C: assinatura/IAP.
- Template D: emissao de PDF profissional.
- Template E: app + painel web administrativo.

---

Status: playbook operacional v1 pronto para uso e evolucao.
