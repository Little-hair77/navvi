import 'package:flutter/material.dart';

import 'detail_screen.dart';
import './models/place_model.dart';
import './services/api_service.dart';

class ListScreen extends StatelessWidget {
  final String type;

  const ListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final title = _titleForType(type);
    final subtitle = _subtitleForType(type);
    final accentColor = _accentForType(type);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),
      body: SafeArea(
        child: FutureBuilder<List<PlaceModel>>(
          future: ApiService().fetchData(type),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _ListHeader(
                    title: title,
                    subtitle: subtitle,
                    accentColor: accentColor,
                  ),
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(color: Color(0xFF6E3CBC)),
                    ),
                  )
                else if (snapshot.hasError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _FeedbackState(
                      icon: Icons.cloud_off_rounded,
                      title: 'Nao foi possivel carregar agora',
                      message: 'Verifique a conexao e tente novamente em instantes.',
                      accentColor: accentColor,
                    ),
                  )
                else if (!snapshot.hasData || snapshot.data!.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _FeedbackState(
                      icon: Icons.travel_explore_rounded,
                      title: 'Nenhum resultado encontrado',
                      message: 'Ainda nao recebemos itens para esta categoria.',
                      accentColor: accentColor,
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
                    sliver: SliverList.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return _PlaceCard(
                          item: item,
                          accentColor: accentColor,
                        );
                      },
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  static String _titleForType(String type) {
    switch (type) {
      case 'accommodation':
        return 'Hospedagens';
      case 'activity':
        return 'Experiencias';
      case 'poi':
        return 'Pontos Turisticos';
      case 'event':
        return 'Cultura';
      default:
        return 'Explorar';
    }
  }

  static String _subtitleForType(String type) {
    switch (type) {
      case 'accommodation':
        return 'Selecao de lugares para descansar com estilo.';
      case 'activity':
        return 'Descubra roteiros, passeios e momentos memoraveis.';
      case 'poi':
        return 'Locais marcantes para colocar no seu proximo trajeto.';
      case 'event':
        return 'Vivencias culturais para enriquecer a viagem.';
      default:
        return 'Ideias selecionadas para sua proxima descoberta.';
    }
  }

  static Color _accentForType(String type) {
    switch (type) {
      case 'accommodation':
        return const Color(0xFF9B5DE5);
      case 'activity':
        return const Color(0xFFEF476F);
      case 'poi':
        return const Color(0xFF118AB2);
      case 'event':
        return const Color(0xFFFF7A59);
      default:
        return const Color(0xFF6E3CBC);
    }
  }
}

class _ListHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accentColor;

  const _ListHeader({
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 10, 18, 6),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor,
            const Color(0xFF21123A),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.28),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _BackButtonChip(accentColor: accentColor),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'NAVVI',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              height: 1.05,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              height: 1.45,
              color: Colors.white.withOpacity(0.82),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButtonChip extends StatelessWidget {
  final Color accentColor;

  const _BackButtonChip({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.16),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => Navigator.of(context).maybePop(),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final PlaceModel item;
  final Color accentColor;

  const _PlaceCard({
    required this.item,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(item: item, accentColor: accentColor)),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2A193D).withOpacity(0.08),
                blurRadius: 26,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Stack(
                  children: [
                    _CardImage(imageUrl: item.imageUrl, accentColor: accentColor),
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.34),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_awesome_rounded, size: 14, color: Colors.white),
                            SizedBox(width: 6),
                            Text(
                              'Selecao Navvi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 21,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF20152F),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.description ?? 'Toque para ver mais detalhes sobre este local.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.5,
                        color: Color(0xFF6D6478),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.place_rounded, size: 16, color: accentColor),
                              const SizedBox(width: 6),
                              Text(
                                'Explorar',
                                style: TextStyle(
                                  color: accentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_rounded, color: accentColor),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String? imageUrl;
  final Color accentColor;

  const _CardImage({
    required this.imageUrl,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _ImagePlaceholder(height: 220, accentColor: accentColor);
    }

    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _ImagePlaceholder(height: 220, accentColor: accentColor);
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return _ImagePlaceholder(height: 220, accentColor: accentColor, isLoading: true);
        },
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final double height;
  final Color accentColor;
  final bool isLoading;

  const _ImagePlaceholder({
    required this.height,
    required this.accentColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withOpacity(0.78),
            const Color(0xFF2D1B46),
          ],
        ),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.landscape_rounded, color: Colors.white, size: 52),
      ),
    );
  }
}

class _FeedbackState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Color accentColor;

  const _FeedbackState({
    required this.icon,
    required this.title,
    required this.message,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.14),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 34, color: accentColor),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF20152F),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.5,
                  color: Color(0xFF6D6478),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
