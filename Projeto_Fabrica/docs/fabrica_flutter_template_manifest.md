# Fabrica Flutter - Template Manifest v1

Manifesto oficial de estrutura para novos apps da Fabrica Flutter PerfectPro.

Data de referencia: 2026-04-20

## 1) Objetivo do manifesto

- Padronizar a criacao de projetos Flutter.
- Evitar omissoes em seguranca, qualidade e release.
- Garantir que todo app nasca pronto para evolucao controlada.

## 2) Estrutura de diretorios obrigatoria

Raiz do projeto:

- `android/`
- `ios/`
- `lib/`
- `test/`
- `integration_test/` (quando aplicavel)
- `docs/`

Dentro de `lib/` (minimo obrigatorio):

- `lib/core/`
- `lib/data/`
- `lib/utils/`
- `lib/screens/`

Estrutura expandida (apps medios/grandes):

- `lib/features/<feature>/data/`
- `lib/features/<feature>/domain/`
- `lib/features/<feature>/presentation/`
- `lib/services/`
- `lib/shared/`

## 3) Arquivos obrigatorios na raiz

- `pubspec.yaml`
- `analysis_options.yaml`
- `.gitignore`
- `.env.example`
- `README.md`

Arquivos de gestao de versao do Flutter (FVM):

- `.fvm/` (local)
- `.fvmrc` ou equivalente de pinagem de versao

## 4) Arquivos obrigatorios Android

- `android/app/build.gradle.kts`
- `android/app/src/main/AndroidManifest.xml`
- `android/key.properties.example`

Requisitos:

- Kotlin DSL obrigatorio (`.gradle.kts`).
- `namespace` e `applicationId` coerentes.
- `minSdk` e `targetSdk` alinhados ao baseline vigente.
- Regras ProGuard/R8 habilitadas para release.

## 5) Arquivos obrigatorios iOS

- `ios/Runner/Info.plist`
- `ios/Runner.xcodeproj/project.pbxproj`

Requisitos:

- Bundle ID consistente com o produto.
- Nome de exibicao configurado.
- Permissoes revisadas no `Info.plist`.

## 6) Base de codigo minima (arquivos sugeridos)

Em `lib/core/`:

- `app_constants.dart`
- `app_theme.dart`
- `app_colors.dart`
- `failure.dart`

Em `lib/data/`:

- `local_database.dart`
- `repositories/` (diretorio)

Em `lib/utils/`:

- `validators.dart`
- `pdf_safe_text.dart` (quando app gerar PDF)

Em `lib/screens/`:

- `home_screen.dart`
- `settings_screen.dart`

## 7) Dependencias minimas recomendadas

- Estado: Riverpod (preferencial)
- Roteamento: GoRouter
- DI: GetIt ou Riverpod
- HTTP: Dio
- Persistencia local: Isar ou Drift
- Serializacao: json_serializable + build_runner
- PDF: pdf + printing
- Logging: logger

## 8) Arquivos de qualidade e automacao

Obrigatorios:

- `analysis_options.yaml` com regras da fabrica.
- Pipeline CI configurada (Codemagic ou GitHub Actions).

Checklist da pipeline minima:

1. `dart format --set-exit-if-changed .`
2. `flutter analyze`
3. `flutter test`
4. Build Android (`.aab`)
5. Build iOS (quando aplicavel)

## 9) Seguranca e segredos (obrigatorio)

No `.gitignore`, bloquear:

- `android/key.properties`
- `android/*.jks`
- `android/*.keystore`
- Arquivos `.env` reais

Regras:

- Apenas exemplos podem ser versionados (`.env.example`, `key.properties.example`).
- Nenhum segredo real pode estar em commit.
- Chaves de release devem ficar em custodia segura.

## 10) Documentacao obrigatoria em `docs/`

Todo app novo deve conter:

- `docs/padrao_de_app.md` (baseline de engenharia)
- `docs/release_checklist.md` (checklist de publicacao)
- `docs/arquitetura.md` (decisoes de arquitetura do app)
- `docs/changelog.md` (historico de entregas)

## 11) Gate de conformidade do template

Projeto so e considerado "template valido" quando:

- Estrutura minima criada.
- Arquivos obrigatorios presentes.
- Qualidade base configurada e executavel.
- Seguranca de segredos aplicada.
- Pipeline minima ativa.
- Documentacao minima criada.

## 12) Registro final padrao

Ao finalizar a criacao do template, registrar:

- O que foi feito (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

---

Status: template manifest v1 pronto para padronizar novos apps da Fabrica Flutter.
