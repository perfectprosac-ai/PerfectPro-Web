# Release Checklist - Fabrica Flutter

Checklist padrao para publicacao de apps Flutter com qualidade e seguranca.

Data de referencia: 2026-04-20

## 1) Pre-release tecnico

- [ ] Projeto atualizado com branch de release.
- [ ] Versao atualizada (`versionName`/`versionCode` e equivalentes iOS).
- [ ] Dependencias travadas e sem conflitos.
- [ ] Build local sem erro (debug e release).

## 2) Qualidade obrigatoria

- [ ] `dart format --set-exit-if-changed .`
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Testes de integracao executados (fluxos criticos).
- [ ] Cobertura minima dos modulos criticos validada.

## 3) Validacao funcional

- [ ] Onboarding/login funcionando.
- [ ] Fluxos principais sem regressao.
- [ ] Persistencia local integra (Isar/Drift/SQLite).
- [ ] Sincronizacao (se aplicavel) validada.
- [ ] Estados offline/online validados.

## 4) Engenharia de PDF (quando aplicavel)

- [ ] Fontes `.ttf` embarcadas e funcionando.
- [ ] Acentos/simbolos renderizados corretamente.
- [ ] Campos compostos com separadores consistentes.
- [ ] `Printing.sharePdf` funcional em dispositivo real.

## 5) Android (Play Console)

- [ ] `namespace` e `applicationId` coerentes.
- [ ] `minSdk` e `targetSdk` conforme baseline.
- [ ] Assinatura release configurada com keystore oficial.
- [ ] `AndroidManifest.xml` revisado (permissoes minimas).
- [ ] ProGuard/R8 ativo e testado.
- [ ] Data Safety atualizado.
- [ ] Billing validado (quando houver IAP).

## 6) iOS (App Store)

- [ ] Bundle ID correto.
- [ ] `Info.plist` revisado (permissoes e descricoes).
- [ ] Provisioning/signing validos.
- [ ] Build em dispositivo iOS validado.

## 7) Seguranca e segredos

- [ ] Nenhum segredo versionado.
- [ ] `android/key.properties` fora do Git.
- [ ] `.jks`/.keystore em custodia segura.
- [ ] `.env` reais fora do repositorio.
- [ ] `.gitignore` revisado.

## 8) CI/CD e artefatos

- [ ] Pipeline verde (lint/test/build).
- [ ] Artefato Android `.aab` gerado.
- [ ] Artefato iOS gerado (quando aplicavel).
- [ ] Assinatura e hashes de integridade registrados.

## 9) Publicacao e pos-release

- [ ] Politica de privacidade publicada e acessivel.
- [ ] Notas de versao preparadas.
- [ ] Publicacao interna / staged rollout configurado.
- [ ] Monitoramento de crashes e ANRs nas primeiras 48h.
- [ ] Plano de rollback/hotfix definido.

## 10) Registro final de release

Preencher ao encerrar:

- O que foi feito (1 linha)
- Status: OK / ERRO
- Proximo passo sugerido

---

Status: template de release checklist pronto para reutilizacao.
