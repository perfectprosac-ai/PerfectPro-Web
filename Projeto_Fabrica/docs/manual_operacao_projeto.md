# Manual de Instrucao do Projeto

Guia simples para qualquer pessoa (ou IA) entender e operar este projeto sem improviso.

## 1) O que e este projeto

- Este repositorio define a base da **Fabrica Flutter PerfectPro**.
- O objetivo e criar apps com padrao tecnico alto, qualidade de release e rastreabilidade.
- A execucao segue metodo controlado: diagnosticar, intervir com escopo minimo e validar.

## 2) Como o projeto funciona (fluxo objetivo)

1. Ler contexto e arquivo alvo completo.
2. Identificar problema ou melhoria.
3. Definir tipo de acao: correcao, refatoracao, implementacao ou validacao.
4. Aplicar alteracao minima necessaria.
5. Validar (build, fluxo, dados locais, PDF quando aplicavel).
6. Registrar resultado final:
   - O que foi feito
   - Status: OK / ERRO
   - Proximo passo sugerido

## 3) Conjunto de padroes oficiais

- `docs/levantamento_fabrica_flutter.md`: especificacao base da fabrica.
- `docs/fabrica_flutter_playbook.md`: processo operacional por fases.
- `docs/fabrica_flutter_bootstrap_checklist.md`: checklist para iniciar app novo.
- `docs/fabrica_flutter_template_manifest.md`: estrutura obrigatoria de template.
- `docs/fabrica_flutter_governanca.md`: regras de branch, PR, review e gates.
- `docs/fabrica_flutter_matriz_decisao.md`: criterios de decisao tecnica.
- `docs/release_checklist.md`: checklist de publicacao.
- `docs/arquitetura.md`: template de decisoes arquiteturais por app.
- `docs/changelog.md`: historico de evolucao por versao.
- `docs/fabrica_flutter_roadmap_implantacao.md`: implantacao 30/60/90 dias.

## 4) Ordem de uso recomendada

1. `docs/levantamento_fabrica_flutter.md`
2. `docs/fabrica_flutter_template_manifest.md`
3. `docs/fabrica_flutter_bootstrap_checklist.md`
4. `docs/fabrica_flutter_playbook.md`
5. `docs/fabrica_flutter_matriz_decisao.md`
6. `docs/fabrica_flutter_governanca.md`
7. `docs/release_checklist.md`

## 5) Regras obrigatorias de execucao

- Usar Flutter stable com FVM.
- Nao versionar segredos (`key.properties`, `.jks`, `.env` real).
- Toda mudanca passa por PR e quality gates.
- Nao alterar partes fora do escopo da tarefa.
- Validar em dispositivo real quando houver fluxo critico (billing, PDF, login).

## 6) Como recriar o projeto em outro repositorio

1. Copiar a pasta `docs/`.
2. Aplicar o template manifest para estrutura inicial.
3. Executar o bootstrap checklist.
4. Configurar CI/CD com gates minimos.
5. Iniciar primeiro app piloto e registrar arquitetura/changelog.

## 7) Proximo passo operacional

- Criar o primeiro app piloto da fabrica usando este manual e o checklist de bootstrap.

---

Status: manual simples e objetivo pronto para orientar continuidade do projeto.
