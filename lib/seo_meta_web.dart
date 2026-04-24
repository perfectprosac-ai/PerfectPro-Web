import 'package:web/web.dart' as web;

void applySeoMetaTags() {
  _upsertMeta('description', 'Software house especialista em Flutter, Java e SDKs para apps mobile, web e desktop com alta performance.');
  _upsertMeta('keywords', 'Flutter, Java, SDK, PWA, SEO, Google Search Console, mobile, web, desktop');
  _upsertMeta('robots', 'index, follow');

  _upsertMetaProperty('og:title', 'Codificando o Amanha, Hoje | PerfectPro');
  _upsertMetaProperty('og:description', 'Inovacao em Flutter, Java e SDKs com foco em codigo limpo, escala e performance.');
  _upsertMetaProperty('og:type', 'website');
}

void _upsertMeta(String name, String content) {
  final head = web.document.head;
  if (head == null) return;
  final tag = (head.querySelector('meta[name="$name"]') as web.HTMLMetaElement?) ?? web.HTMLMetaElement()..name = name;
  if (tag.parentNode == null) head.append(tag);
  tag.content = content;
}

void _upsertMetaProperty(String property, String content) {
  final head = web.document.head;
  if (head == null) return;
  final tag = (head.querySelector('meta[property="$property"]') as web.HTMLMetaElement?)
      ?? (web.HTMLMetaElement()..setAttribute('property', property));
  if (tag.parentNode == null) head.append(tag);
  tag.content = content;
}
