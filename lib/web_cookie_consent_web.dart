import 'package:web/web.dart' as web;

/// Indica se o utilizador já tomou uma decisão explícita (aceitar ou recusar).
bool isCookieChoiceStored() {
  try {
    final v = web.window.localStorage.getItem('pp_cookie_consent');
    return v != null && v.isNotEmpty;
  } catch (_) {
    return true;
  }
}

/// Grava aceitação de cookies de medição (lido pelo script em `web/index.html` antes do gtag).
void grantAnalyticsMeasurementConsent() {
  web.window.localStorage.setItem('pp_cookie_consent', 'granted');
}

/// Grava recusa explícita (medição permanece desativada até nova decisão).
void denyAnalyticsMeasurementConsent() {
  web.window.localStorage.setItem('pp_cookie_consent', 'denied');
}
