# Implantacao Multilingue (BRL + USD) - Mini Plano Tecnico

## Objetivo
Preparar o app Flutter para suporte multilingue com foco em regras de moeda (BRL + USD), sem quebrar calculos financeiros.

Separar claramente:
- idioma (textos);
- localidade (formato de data/numero/moeda);
- regra de negocio (calculo e persistencia de valores).

## 1) Base de i18n e locale

### Arquivos
- `pubspec.yaml`
- `lib/main.dart`
- `lib/l10n/app_pt.arb`
- `lib/l10n/app_en.arb`
- `lib/services/app_settings_service.dart` (novo)

### Mudancas
- Adicionar `flutter_localizations` e `intl` no `pubspec.yaml`.
- Configurar em `main.dart`:
  - `localizationsDelegates`
  - `supportedLocales`
  - `locale` dinamico via preferencia salva.
- Persistir configuracoes em `SharedPreferences`:
  - `locale` (`pt_BR`/`en_US`)
  - `currencyCode` (`BRL`/`USD`)

## 2) Camada unica de dinheiro (sem risco de quebra)

### Arquivos
- `lib/utils/money.dart` (novo)
- Refatorar telas:
  - `lib/screens/tela_orcamento.dart`
  - `lib/screens/tela_caixa.dart`
  - `lib/screens/tela_dashboard.dart`
  - `lib/screens/tela_ordem_servico.dart`
  - `lib/screens/tela_contrato_editor.dart`

### API sugerida para `money.dart`
- `parseUserInputToDouble(String input, Locale locale)`
- `formatMoney(num value, {required String currencyCode, required Locale locale})`
- `toMinorUnits(num value)` e `fromMinorUnits(int cents)` (opcional, recomendado)

### Regra
- Calculo interno sempre numerico (preferencialmente centavos em `int` para maxima seguranca).
- Nao espalhar `replaceAll(',', '.')` nas telas.
- Toda exibicao monetaria deve passar por `formatMoney(...)`.

## 3) Banco de dados pronto para multi-moeda

### Arquivo
- `lib/database/database_helper.dart`

### Migracao (versao 13)
Adicionar `currency_code` com default `BRL`:
- `orcamentos.currency_code TEXT NOT NULL DEFAULT 'BRL'`
- `caixa_lancamentos.currency_code TEXT NOT NULL DEFAULT 'BRL'`

### Resultado
- Registros antigos seguem validos como BRL.
- Registros novos passam a carregar moeda explicita por linha.

## 4) Contrato/PDF com moeda e locale corretos

### Arquivo
- `lib/screens/tela_contrato_editor.dart`

### Mudancas
- Remover formatacao manual de moeda (`toStringAsFixed + replaceAll`).
- Aplicar formatacao por locale/moeda via `money.dart`.
- Permitir contrato com BRL ou USD sem alterar a logica de calculo.
- Manter texto juridico em PT-BR inicialmente (fase 1), com internacionalizacao de interface primeiro.

## 5) Configuracoes para o usuario

### Arquivo
- `lib/screens/tela_configuracoes.dart`

### Adicoes
- Seletor de idioma:
  - Portugues (Brasil)
  - English (US)
- Seletor de moeda padrao:
  - BRL
  - USD
- Persistencia das escolhas no `app_settings_service.dart`.

## 6) Ordem de implantacao (baixo risco)

1. Adicionar `intl` e `flutter_localizations`.
2. Criar `money.dart` e refatorar primeiro `tela_orcamento.dart`.
3. Refatorar `tela_caixa.dart`.
4. Refatorar `tela_dashboard.dart`, `tela_ordem_servico.dart` e `tela_contrato_editor.dart`.
5. Aplicar migracao DB v13 para `currency_code`.
6. Expor controles de idioma/moeda em `tela_configuracoes.dart`.

## 7) Checklist de validacao

- Orcamento BRL: total, desconto e PDF corretos.
- Orcamento USD: total, desconto e PDF corretos.
- Caixa: entradas e saidas sem erro de parse.
- Troca de locale (`pt_BR`/`en_US`) altera apenas formato visual, sem alterar valor numerico.
- Base antiga abre sem crash e assume BRL por default.

## Entrega minima recomendada (MVP)

- Fase 1: infraestrutura de locale + money util + refator de `tela_orcamento.dart`.
- Fase 2: refator `tela_caixa.dart` + migracao `currency_code`.
- Fase 3: PDF/contrato + dashboard + ordem de servico.
