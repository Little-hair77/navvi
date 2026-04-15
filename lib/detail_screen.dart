import 'package:flutter/material.dart';

import './models/place_model.dart';

class DetailScreen extends StatelessWidget {
  final PlaceModel item;
  final Color accentColor;

  const DetailScreen({
    super.key,
    required this.item,
    this.accentColor = const Color(0xFF6E3CBC),
  });

  @override
  Widget build(BuildContext context) {
    final description = item.description ??
        'Nenhuma descricao detalhada esta disponivel para este local no momento.';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 360,
            elevation: 0,
            backgroundColor: const Color(0xFF21123A),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _HeroImage(
                    imageUrl: item.imageUrl,
                    accentColor: accentColor,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.12),
                          Colors.black.withOpacity(0.18),
                          Colors.black.withOpacity(0.76),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 96, 22, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'DESTINO EM DESTAQUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          item.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.06,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _QuickInfoChip(
                              icon: Icons.auto_awesome_rounded,
                              label: 'Curadoria Navvi',
                              accentColor: accentColor,
                            ),
                            const SizedBox(width: 10),
                            const _QuickInfoChip(
                              icon: Icons.visibility_rounded,
                              label: 'Visual inspirador',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -26),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    _InfoPanel(
                      accentColor: accentColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    height: 1.15,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1F1630),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(Icons.bookmark_add_outlined, color: accentColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F3EE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: accentColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(Icons.map_outlined, color: accentColor),
                                ),
                                const SizedBox(width: 14),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pronto para explorar',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1F1630),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Confira os detalhes e use esta referencia para inspirar sua rota.',
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          height: 1.45,
                                          color: Color(0xFF6D6478),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _InfoPanel(
                      accentColor: accentColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: accentColor,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Sobre o lugar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1F1630),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 15.5,
                              height: 1.7,
                              color: Color(0xFF51495E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _InfoPanel(
                      accentColor: accentColor,
                      child: Row(
                        children: [
                          Expanded(
                            child: _ActionTile(
                              icon: Icons.share_outlined,
                              label: 'Compartilhar',
                              accentColor: accentColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _ActionTile(
                              icon: Icons.route_outlined,
                              label: 'Salvar ideia',
                              accentColor: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String? imageUrl;
  final Color accentColor;

  const _HeroImage({
    required this.imageUrl,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _HeroPlaceholder(accentColor: accentColor);
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _HeroPlaceholder(accentColor: accentColor),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _HeroPlaceholder(accentColor: accentColor, isLoading: true);
      },
    );
  }
}

class _HeroPlaceholder extends StatelessWidget {
  final Color accentColor;
  final bool isLoading;

  const _HeroPlaceholder({
    required this.accentColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor,
            const Color(0xFF21123A),
          ],
        ),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.photo_camera_back_rounded, color: Colors.white, size: 66),
      ),
    );
  }
}

class _QuickInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? accentColor;

  const _QuickInfoChip({
    required this.icon,
    required this.label,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: accentColor?.withOpacity(0.20) ?? Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final Widget child;
  final Color accentColor;

  const _InfoPanel({
    required this.child,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: accentColor),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
