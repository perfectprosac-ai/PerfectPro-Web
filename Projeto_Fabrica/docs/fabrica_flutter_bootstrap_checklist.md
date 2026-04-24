# Fabrica Flutter - Bootstrap Checklist v1

Checklist operacional para iniciar um novo app Flutter no padrao da Fabrica Flutter PerfectPro.

Data de referencia: 2026-04-20

## 1) Preparacao de ambiente (uma vez por maquina)

- [ ] Instalar Flutter (canal stable).
- [ ] Instalar FVM.
- [ ] Instalar Android Studio + SDKs necessarios.
- [ ] Instalar JDK compativel com stack alvo.
- [ ] Instalar Xcode (macOS) e aceitar licencas.
- [ ] Validar ambiente com `flutter doctor`.
- [ ] Configurar Git e chave de acesso ao repositorio.

## 2) Criacao do projeto base

- [ ] Criar repositorio remoto.
- [ ] Criar projeto Flutter com nome padronizado.
- [ ] Inicializar FVM no projeto (`fvm use <versao_flutter>`).
- [ ] Fixar versao do Flutter no arquivo de configuracao do FVM.
- [ ] Rodar app base em Android.
- [ ] Rodar app base em iOS (quando aplicavel).

## 3) Padronizacao de estrutura de pastas

- [ ] Criar estrutura minima:
  - [ ] `lib/core`
  - [ ] `lib/data`
  - [ ] `lib/utils`
  - [ ] `lib/screens`
- [ ] Criar estrutura expandida (se necessario):
  - [ ] `lib/features/<feature>/data`
  - [ ] `lib/features/<feature>/domain`
  - [ ] `lib/features/<feature>/presentation`
  - [ ] `lib/services`
  - [ ] `lib/shared`

## 4) Configuracao de qualidade

- [ ] Definir regras de analise estatica.
- [ ] Configurar formatacao automatica.
- [ ] Configurar testes (unitario/widget/integracao).
- [ ] Criar comando padrao de validacao:
  - [ ] `dart format .`
  - [ ] `flutter analyze`
  - [ ] `flutter test`

## 5) Dependencias base do projeto

- [ ] Definir gerenciador de estado (Riverpod preferencial).
- [ ] Definir roteamento (GoRouter preferencial).
- [ ] Definir injecao de dependencia (GetIt ou Riverpod).
- [ ] Definir persistencia local (Isar ou Drift/SQLite).
- [ ] Definir cliente HTTP (Dio).
- [ ] Definir serializacao (`json_serializable` + `build_runner`).
- [ ] Definir logging e crash analytics.

## 6) Configuracao Android nativo

- [ ] Garantir uso de Gradle Kotlin DSL (`.gradle.kts`).
- [ ] Configurar `namespace` e `applicationId` coerentes.
- [ ] Definir `minSdk` e `targetSdk` conforme baseline atual.
- [ ] Preparar suporte a MethodChannel (se necessario).
- [ ] Configurar regras ProGuard/R8 para release.
- [ ] Revisar permissoes do `AndroidManifest.xml`.

## 7) Configuracao iOS nativo

- [ ] Configurar bundle id consistente.
- [ ] Configurar nome de exibicao do app.
- [ ] Revisar chaves de permissao no `Info.plist`.
- [ ] Validar provisioning/signing por ambiente.

## 8) Segredos e seguranca

- [ ] Criar `android/key.properties.example` (modelo).
- [ ] Criar `android/key.properties` local (nao versionar).
- [ ] Gerar keystore `.jks` com custodia segura.
- [ ] Configurar `.env.example` por ambiente (`dev`, `hml`, `prod`).
- [ ] Revisar `.gitignore` para bloquear segredos.

## 9) Engenharia de documentos (PDF)

- [ ] Adicionar `pdf` package.
- [ ] Adicionar `printing` package.
- [ ] Registrar fontes `.ttf` no `pubspec.yaml`.
- [ ] Criar utilitario de sanitizacao de texto para PDF.
- [ ] Validar acentos/simbolos em PDF em dispositivo real.

## 10) CI/CD inicial

- [ ] Escolher esteira: Codemagic ou GitHub Actions.
- [ ] Fixar Flutter via FVM na pipeline.
- [ ] Criar pipeline com:
  - [ ] lint/analise
  - [ ] testes
  - [ ] build Android (`.aab`)
  - [ ] build iOS (quando aplicavel)
- [ ] Publicacao interna automatizada para validacao.

## 11) Publicacao e compliance

- [ ] Preparar politica de privacidade publica.
- [ ] Configurar Data Safety (Android).
- [ ] Configurar Billing (quando houver IAP).
- [ ] Validar checklist final em dispositivo fisico.
- [ ] Gerar artefatos finais de release.

## 12) Gate final de bootstrap

Marcar projeto como "pronto para desenvolvimento de features" somente se:

- [ ] Build debug Android/iOS OK.
- [ ] Qualidade base configurada e executando.
- [ ] Estrutura de pastas aprovada.
- [ ] Segredos protegidos.
- [ ] CI/CD ativo.
- [ ] Compliance inicial preparado.

## 13) Registro padrao de encerramento do bootstrap

Usar sempre ao final desta fase:

- O que foi feito (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

---

Status: checklist de bootstrap pronto para uso imediato.
