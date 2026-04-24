import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_theme.dart';
import 'seo_meta_stub.dart' if (dart.library.html) 'seo_meta_web.dart' as seo_meta;

/// Loops, parallax e oscilações contínuas — respeita “reduzir movimento” do SO/navegador.
bool allowRichMotion(BuildContext context) {
  if (MediaQuery.disableAnimationsOf(context)) return false;
  if (SchedulerBinding.instance.platformDispatcher.accessibilityFeatures.reduceMotion) {
    return false;
  }
  return true;
}

/// Superfícies decorativas estáticas (ex.: gradiente fixo no título) quando animações não foram desligadas pelo ancestral.
bool allowStaticHeroDecor(BuildContext context) => !MediaQuery.disableAnimationsOf(context);

void main() {
  seo_meta.applySeoMetaTags();
  runApp(const PerfectProSiteApp());
}

class PerfectProSiteApp extends StatefulWidget {
  const PerfectProSiteApp({super.key});

  @override
  State<PerfectProSiteApp> createState() => _PerfectProSiteAppState();
}

class _PerfectProSiteAppState extends State<PerfectProSiteApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PerfectPro',
      theme: buildPerfectProLightTheme(),
      darkTheme: buildPerfectProDarkTheme(),
      themeMode: _themeMode,
      home: SiteHomePage(onToggleTheme: _toggleTheme),
    );
  }
}

class SiteHomePage extends StatefulWidget {
  const SiteHomePage({super.key, required this.onToggleTheme});
  final VoidCallback onToggleTheme;

  @override
  State<SiteHomePage> createState() => _SiteHomePageState();
}

class _SiteHomePageState extends State<SiteHomePage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollPixels = ValueNotifier<double>(0);
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _solutionsKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  static const double _headerHeight = 76;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    _scrollPixels.value = _scrollController.offset;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollPixels.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final offset = box.localToGlobal(Offset.zero).dy + _scrollController.offset - _headerHeight - 12;
    _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: _headerHeight + 12),
                HeroSection(key: _homeKey, scrollListenable: _scrollPixels),
                SectionCard(
                  key: _solutionsKey,
                  title: 'Solucoes (App/Web)',
                  child: AnimatedSolutionsSectionContent(scrollListenable: _scrollPixels),
                ),
                SectionCard(
                  key: _portfolioKey,
                  title: 'Portfolio',
                  child: const PortfolioMotionBlock(),
                ),
                SectionCard(
                  key: _contactKey,
                  title: 'Contato',
                  child: const ContactMotionBlock(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteHeader(
              height: _headerHeight,
              onToggleTheme: widget.onToggleTheme,
              onHome: () => _scrollTo(_homeKey),
              onSolutions: () => _scrollTo(_solutionsKey),
              onPortfolio: () => _scrollTo(_portfolioKey),
              onAbout: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(builder: (_) => SobreNosPage(onToggleTheme: widget.onToggleTheme)),
                  ),
              onContact: () => _scrollTo(_contactKey),
            ),
          ),
        ],
      ),
    );
  }
}

/// Página institucional com textos do material de referência do projeto.
class SobreNosPage extends StatelessWidget {
  const SobreNosPage({super.key, this.onToggleTheme});

  /// Mesmo callback do início para alternar tema nesta rota.
  final VoidCallback? onToggleTheme;

  static const String _empresaTitulo = 'Codificando o Amanhã, Hoje.';
  static const String _empresaCorpo =
      'Somos uma software house especializada em arquiteturas de alta performance. Unimos o poder do Dart/Flutter à robustez do Java para criar ecossistemas digitais que não apenas funcionam, mas escalam. Nossa missão é transformar lógica complexa em experiências de usuário simplificadas, garantindo que sua infraestrutura técnica seja o alicerce do seu crescimento, e não um gargalo.';

  static const String _appsTitulo = 'Apps Nativos com Performance de Próxima Geração';
  static const String _appsCorpo =
      'Desenvolvemos aplicações móveis utilizando as ferramentas mais avançadas do mercado. Com Flutter, entregamos uma base de código única para iOS e Android sem sacrificar a performance nativa. Dominamos a integração de SDKs proprietários e APIs complexas, garantindo que seu aplicativo tenha acesso total ao hardware e ofereça uma fluidez impecável para o usuário final.';

  static const String _webTitulo = 'Web Apps Rápidos, Responsivos e Indexáveis';
  static const String _webCorpo =
      'Sua presença na web precisa ser instantânea. Criamos plataformas web modernas com foco total em Core Web Vitals. Nossas soluções web são projetadas para carregamento ultra-rápido e total conformidade com os algoritmos de busca do Google. De painéis administrativos complexos a interfaces de consumo, entregamos código limpo, otimizado para conversão e 100% responsivo.';

  static const String _desktopTitulo = 'Software Desktop: Potência Máxima no Windows';
  static const String _desktopCorpo =
      'Levamos a experiência do usuário para o desktop com aplicações Windows robustas. Utilizamos o potencial do ecossistema Dart e integração Java para criar softwares que aproveitam ao máximo o poder de processamento local. Ideal para ferramentas de produtividade, sistemas de gestão offline ou softwares que exigem alta capacidade de resposta e integração profunda com o sistema operacional.';

  static const String _porQueTitulo = 'Por que nós?';
  static const String _porQueCorpo =
      '• Código Limpo: Arquitetura limpa (Clean Architecture) para fácil manutenção.\n'
      '• Segurança: Implementação de protocolos de segurança de nível bancário.\n'
      '• Escalabilidade: Sistemas prontos para suportar de 100 a 1 milhão de usuários.\n'
      '• Suporte Full-Stack: Do design da UI à engenharia de back-end.';

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Página Sobre nós da empresa',
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.96),
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
            tooltip: 'Voltar ao início',
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Sobre nós', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface)),
          actions: [
            IconButton(
              tooltip: 'WhatsApp',
              onPressed: _openWhatsApp,
              icon: Icon(Icons.chat_rounded, color: Theme.of(context).colorScheme.primary),
            ),
            IconButton(
              tooltip: 'E-mail SAC',
              onPressed: _openSacEmail,
              icon: Icon(Icons.mail_outline_rounded, color: Theme.of(context).colorScheme.primary),
            ),
            if (onToggleTheme != null)
              IconButton(
                tooltip: Theme.of(context).brightness == Brightness.dark ? 'Tema claro' : 'Tema escuro',
                onPressed: onToggleTheme,
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transformação digital e robustez do código',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SectionText(title: _empresaTitulo, body: _empresaCorpo),
                  const SizedBox(height: 22),
                  const SectionText(title: _appsTitulo, body: _appsCorpo),
                  const SizedBox(height: 22),
                  const SectionText(title: _webTitulo, body: _webCorpo),
                  const SizedBox(height: 22),
                  const SectionText(title: _desktopTitulo, body: _desktopCorpo),
                  const SizedBox(height: 22),
                  const SectionText(title: _porQueTitulo, body: _porQueCorpo),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _openWhatsApp() async {
  final uri = Uri.parse('https://wa.me/$kWhatsAppDigits');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> _openSacEmail() async {
  final uri = Uri(
    scheme: 'mailto',
    path: kEmailSac,
    queryParameters: {'subject': 'Contato PerfectPro'},
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

Future<void> _openSiteUrl() async {
  final uri = Uri.parse('https://perfectpro.app/');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class SiteHeader extends StatelessWidget {
  const SiteHeader({
    super.key,
    required this.height,
    required this.onToggleTheme,
    required this.onHome,
    required this.onSolutions,
    required this.onPortfolio,
    required this.onAbout,
    required this.onContact,
  });

  final double height;
  final VoidCallback onToggleTheme;
  final VoidCallback onHome;
  final VoidCallback onSolutions;
  final VoidCallback onPortfolio;
  final VoidCallback onAbout;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Semantics(
      label: 'Cabecalho fixo com navegacao principal',
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.94),
          border: Border(bottom: BorderSide(color: cs.primary.withValues(alpha: isDark ? 0.22 : 0.35))),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 34,
              width: 34,
              child: Image.asset(
                'IMAGENS_APP/PerfectPro_Logo_Transparente.png',
                fit: BoxFit.contain,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
                    Icon(Icons.circle_outlined, color: cs.primary, size: 24),
              ),
            ),
            const SizedBox(width: 6),
            TextButton(
              onPressed: _openSiteUrl,
              child: Text(
                'PerfectPro',
                style: TextStyle(
                  color: cs.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              tooltip: 'WhatsApp',
              onPressed: _openWhatsApp,
              icon: Icon(Icons.chat_rounded, color: cs.primary, size: 22),
            ),
            IconButton(
              tooltip: 'E-mail SAC',
              onPressed: _openSacEmail,
              icon: Icon(Icons.mail_outline_rounded, color: cs.primary, size: 22),
            ),
            IconButton(
              tooltip: isDark ? 'Tema claro' : 'Tema escuro',
              onPressed: onToggleTheme,
              icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: cs.primary, size: 22),
            ),
            const Spacer(),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _HeaderBtn(label: 'Home', onTap: onHome),
                    _HeaderBtn(label: 'Solucoes (App/Web)', onTap: onSolutions),
                    _HeaderBtn(label: 'Portfolio', onTap: onPortfolio),
                    _HeaderBtn(label: 'Sobre nós', onTap: onAbout),
                    _HeaderBtn(label: 'Contato', onTap: onContact),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  const _HeaderBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: TextButton(
        onPressed: onTap,
        child: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 13)),
      ),
    );
  }
}

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.scrollListenable});
  final ValueListenable<double> scrollListenable;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _ambient = AnimationController(vsync: this, duration: const Duration(seconds: 6));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (allowRichMotion(context)) {
        _ambient.repeat();
      } else {
        _ambient.value = 0;
      }
    });
  }

  @override
  void dispose() {
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = allowRichMotion(context);
    final staticDecor = allowStaticHeroDecor(context);
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: 'Secao principal de apresentacao',
      child: ValueListenableBuilder<double>(
        valueListenable: widget.scrollListenable,
        builder: (context, scroll, _) {
          final parallaxY = motion ? -scroll * 0.07 : 0.0;
          return Transform.translate(
            offset: Offset(0, parallaxY),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
              child: AnimatedBuilder(
                animation: _ambient,
                builder: (context, _) {
                  final pulse = motion ? (0.45 + 0.55 * (0.5 + 0.5 * math.sin(_ambient.value * math.pi * 2))) : 0.55;
                  final borderColor = Color.lerp(cs.outline, cs.primary, pulse * 0.55)!;
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderColor, width: 1),
                      boxShadow: motion
                          ? [
                              BoxShadow(
                                color: cs.primary.withValues(alpha: 0.06 + 0.1 * math.sin(_ambient.value * math.pi * 2)),
                                blurRadius: 28,
                                spreadRadius: 0,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: cs.primary.withValues(alpha: 0.08),
                                blurRadius: 22,
                                spreadRadius: 0,
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (staticDecor)
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) {
                              final angle = motion ? _ambient.value * math.pi * 1.25 : 0.0;
                              return LinearGradient(
                                colors: [
                                  cs.onSurface.withValues(alpha: 0.55),
                                  cs.primary,
                                  cs.onSurface.withValues(alpha: 0.85),
                                ],
                                stops: const [0.15, 0.5, 0.85],
                                transform: GradientRotation(angle),
                              ).createShader(bounds);
                            },
                            child: const Text(
                              'Inovacao em Flutter, Java e SDKs',
                              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, height: 1.12, color: Colors.white),
                            ),
                          )
                        else
                          Text(
                            'Inovacao em Flutter, Java e SDKs',
                            style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, height: 1.12, color: cs.onSurface),
                          ),
                        const SizedBox(height: 12),
                        Text(
                          'Desenvolvendo o futuro mobile e web com codigo limpo',
                          style: TextStyle(
                            fontSize: 18,
                            color: cs.onSurface.withValues(alpha: motion ? 0.72 + 0.08 * math.sin(_ambient.value * math.pi * 2 + 1) : 0.78),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Vitrine com movimento suave (flutuação) e leve resposta ao hover no web/desktop.
class AnimatedSolutionsSectionContent extends StatefulWidget {
  const AnimatedSolutionsSectionContent({super.key, required this.scrollListenable});
  final ValueListenable<double> scrollListenable;

  @override
  State<AnimatedSolutionsSectionContent> createState() => _AnimatedSolutionsSectionContentState();
}

class _AnimatedSolutionsSectionContentState extends State<AnimatedSolutionsSectionContent> with TickerProviderStateMixin {
  late final AnimationController _floatCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 5));
  late final AnimationController _enterCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (allowRichMotion(context)) {
        _floatCtrl.repeat();
      } else {
        _floatCtrl.value = 0;
      }
      _enterCtrl.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _enterCtrl.dispose();
    super.dispose();
  }

  Animation<double> _fadeIn(double begin, double end) {
    return CurvedAnimation(parent: _enterCtrl, curve: Interval(begin, end, curve: Curves.easeOutCubic));
  }

  Animation<Offset> _slideIn(double begin, double end) {
    return Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
      CurvedAnimation(parent: _enterCtrl, curve: Interval(begin, end, curve: Curves.easeOutCubic)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _fadeIn(0.0, 0.35),
          child: SlideTransition(
            position: _slideIn(0.0, 0.35),
            child: AnimatedBuilder(
              animation: Listenable.merge([_floatCtrl, widget.scrollListenable]),
              builder: (context, _) {
                return Semantics(
                  label: 'Vitrine de projetos em mockups de dispositivos',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _floatedDevice(0, const DeviceFrame(title: 'Android 14', width: 190, height: 390, radius: 34, imageAsset: 'IMAGENS_APP/Screenshot_20260423-120800.jpg', imageLeft: 20, imageTop: 22, imageWidth: 150, imageHeight: 342)),
                      _floatedDevice(1, const DeviceFrame(title: 'iPhone 15 Pro', width: 190, height: 390, radius: 38, imageAsset: 'IMAGENS_APP/Screenshot_20260423-120808.jpg', imageLeft: 18, imageTop: 22, imageWidth: 154, imageHeight: 342)),
                      _floatedDevice(2, const DeviceFrame(title: 'iPad Pro', width: 330, height: 250, radius: 24, imageAsset: 'IMAGENS_APP/Screenshot_20260423-120855.jpg', imageLeft: 20, imageTop: 20, imageWidth: 290, imageHeight: 206)),
                      _floatedDevice(3, const DeviceFrame(title: 'MacBook', width: 430, height: 270, radius: 18, imageAsset: 'IMAGENS_APP/Screenshot_20260423-120907.jpg', imageLeft: 20, imageTop: 36, imageWidth: 390, imageHeight: 210, withDesktopBar: true)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeTransition(
          opacity: _fadeIn(0.12, 0.55),
          child: SlideTransition(
            position: _slideIn(0.12, 0.55),
            child: const SectionText(
              title: 'Apps Nativos com Performance de Proxima Geracao',
              body: 'Com Flutter, entregamos uma base unica para iOS e Android sem sacrificar performance nativa, com integracao de SDKs e APIs complexas.',
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: _fadeIn(0.28, 0.85),
          child: SlideTransition(
            position: _slideIn(0.28, 0.85),
            child: const SectionText(
              title: 'Web Apps Rapidos, Responsivos e Indexaveis',
              body: 'Solucoes com foco em Core Web Vitals e Google Search Console, orientadas para carregamento rapido e conversao.',
            ),
          ),
        ),
      ],
    );
  }

  Widget _floatedDevice(int index, Widget child) {
    final motion = allowRichMotion(context);
    final t = _floatCtrl.value;
    final scroll = widget.scrollListenable.value;
    final dy = motion ? 5.0 * math.sin(2 * math.pi * t + index * 1.05) : 0.0;
    final px = motion ? scroll * 0.012 * (index - 1.5) : 0.0;
    final rotY = motion ? 0.055 * math.sin(2 * math.pi * t * 0.65 + index * 0.9) : 0.0;
    return RepaintBoundary(
      child: _HoverLift(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(rotY),
          child: Transform.translate(offset: Offset(px, dy), child: child),
        ),
      ),
    );
  }
}

/// Portfolio: entrada escalonada + ícones de competências com micro-animação.
class PortfolioMotionBlock extends StatefulWidget {
  const PortfolioMotionBlock({super.key});

  @override
  State<PortfolioMotionBlock> createState() => _PortfolioMotionBlockState();
}

class _PortfolioMotionBlockState extends State<PortfolioMotionBlock> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: CurvedAnimation(parent: _c, curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic)),
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
              CurvedAnimation(parent: _c, curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic)),
            ),
            child: const SectionText(
              title: 'Diferenciais',
              body: '- Codigo Limpo\n- Seguranca\n- Escalabilidade\n- Suporte Full-Stack',
            ),
          ),
        ),
        const SizedBox(height: 18),
        AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _demoChip(context, Icons.architecture, 'Clean Arch', 0),
                _demoChip(context, Icons.security, 'Seguranca', 1),
                _demoChip(context, Icons.trending_up, 'Escala', 2),
                _demoChip(context, Icons.hub, 'Full-Stack', 3),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _demoChip(BuildContext context, IconData icon, String label, int index) {
    final cs = Theme.of(context).colorScheme;
    final start = 0.35 + index * 0.12;
    final end = (start + 0.35).clamp(0.0, 1.0);
    final v = CurvedAnimation(parent: _c, curve: Interval(start, end, curve: Curves.elasticOut)).value;
    return Opacity(
      opacity: v.clamp(0.0, 1.0),
      child: Transform.scale(
        scale: 0.85 + 0.15 * v,
        child: Chip(
          avatar: Icon(icon, size: 18, color: cs.primary),
          label: Text(label, style: const TextStyle(fontSize: 12)),
          side: BorderSide(color: cs.outline),
          backgroundColor: cs.surface,
        ),
      ),
    );
  }
}

/// Contato: entrada + CTA com pulse e SnackBar de demonstração.
class ContactMotionBlock extends StatefulWidget {
  const ContactMotionBlock({super.key});

  @override
  State<ContactMotionBlock> createState() => _ContactMotionBlockState();
}

class _ContactMotionBlockState extends State<ContactMotionBlock> with TickerProviderStateMixin {
  late final AnimationController _enter = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _enter.forward();
      if (allowRichMotion(context)) _pulse.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _enter.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = allowRichMotion(context);
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: 'Contacto WhatsApp e e-mail',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ActionChip(
                avatar: Icon(Icons.chat_rounded, size: 18, color: cs.primary),
                label: const Text('+55 51 989045442'),
                onPressed: _openWhatsApp,
                side: BorderSide(color: cs.outline),
                backgroundColor: cs.surface,
              ),
              ActionChip(
                avatar: Icon(Icons.alternate_email_rounded, size: 18, color: cs.primary),
                label: Text(kEmailSac, style: const TextStyle(fontSize: 12.5)),
                onPressed: _openSacEmail,
                side: BorderSide(color: cs.outline),
                backgroundColor: cs.surface,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        FadeTransition(
          opacity: CurvedAnimation(parent: _enter, curve: const Interval(0.0, 0.55, curve: Curves.easeOut)),
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
              CurvedAnimation(parent: _enter, curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic)),
            ),
            child: const SectionText(
              title: 'Vamos construir seu proximo produto',
              body: 'Foco em eficiencia, estabilidade e entrega continua para mobile, web e desktop.',
            ),
          ),
        ),
        const SizedBox(height: 18),
        FadeTransition(
          opacity: CurvedAnimation(parent: _enter, curve: const Interval(0.35, 1.0, curve: Curves.easeOut)),
          child: ScaleTransition(
            scale: motion
                ? Tween<double>(begin: 1.0, end: 1.045).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut))
                : const AlwaysStoppedAnimation<double>(1.0),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Demonstracao: mensagem recebida. Em producao, isto abriria o canal de contato.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('Enviar mensagem (demo)'),
            ),
          ),
        ),
      ],
    );
  }
}

class _HoverLift extends StatefulWidget {
  const _HoverLift({required this.child});
  final Widget child;

  @override
  State<_HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<_HoverLift> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

class DeviceFrame extends StatelessWidget {
  const DeviceFrame({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.radius,
    required this.imageAsset,
    required this.imageLeft,
    required this.imageTop,
    required this.imageWidth,
    required this.imageHeight,
    this.withDesktopBar = false,
  });

  final String title;
  final double width;
  final double height;
  final double radius;
  final String imageAsset;
  final double imageLeft;
  final double imageTop;
  final double imageWidth;
  final double imageHeight;
  final bool withDesktopBar;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final codeStyle = GoogleFonts.jetBrainsMono(textStyle: TextStyle(color: cs.primary, fontSize: 11));
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF181818) : const Color(0xFFF2F4F5),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: cs.primary.withValues(alpha: 0.45)),
      ),
      child: Stack(
        children: [
          if (withDesktopBar)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
                child: SizedBox(height: 28, child: ColoredBox(color: cs.surfaceContainerHigh)),
              ),
            ),
          Positioned(
            left: imageLeft,
            top: imageTop,
            width: imageWidth,
            height: imageHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    ColoredBox(color: cs.surfaceContainerHigh),
              ),
            ),
          ),
          Positioned(left: 10, bottom: 8, child: Text(title, style: codeStyle)),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Secao $title',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.65)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  const SectionText({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: cs.primary)),
          const SizedBox(height: 8),
          Text(body, style: TextStyle(fontSize: 15, color: cs.onSurface.withValues(alpha: 0.78), height: 1.45)),
        ],
      ),
    );
  }
}

