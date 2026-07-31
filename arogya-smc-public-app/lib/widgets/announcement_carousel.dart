// lib/widgets/announcement_carousel.dart
//
// Advisory carousel – displays real data from /advisories API endpoint.

import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/advisory_model.dart';

// Predefined gradient pairs for carousel cards (cycling through when advisory
// doesn't specify colours).
const _kGradients = [
  [Color(0xFFB45309), Color(0xFFF97316)],
  [Color(0xFF0F766E), Color(0xFF06B6D4)],
  [Color(0xFF7C3AED), Color(0xFFA78BFA)],
  [Color(0xFFDC2626), Color(0xFFF87171)],
  [Color(0xFF0369A1), Color(0xFF38BDF8)],
];

class AnnouncementCarousel extends StatefulWidget {
  final List<AdvisoryModel> advisories;
  const AnnouncementCarousel({super.key, required this.advisories});

  @override
  State<AnnouncementCarousel> createState() => _AnnouncementCarouselState();
}

class _AnnouncementCarouselState extends State<AnnouncementCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (widget.advisories.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients && widget.advisories.isNotEmpty) {
        final next = (_currentPage + 1) % widget.advisories.length;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.advisories.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.advisories.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (ctx, i) {
              final advisory = widget.advisories[i];
              final gradient = _kGradients[i % _kGradients.length];
              return _AdvisorySlide(
                advisory: advisory,
                gradientStart: gradient[0],
                gradientEnd: gradient[1],
              );
            },
          ),
          // Dot indicators
          if (widget.advisories.length > 1)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.advisories.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentPage == i ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withValues(alpha: _currentPage == i ? 1.0 : 0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AdvisorySlide extends StatelessWidget {
  final AdvisoryModel advisory;
  final Color gradientStart;
  final Color gradientEnd;

  const _AdvisorySlide({
    required this.advisory,
    required this.gradientStart,
    required this.gradientEnd,
  });

  IconData _iconForCategory(String? category) {
    switch ((category ?? '').toLowerCase()) {
      case 'dengue':
        return Icons.warning_amber_rounded;
      case 'vaccination':
      case 'vaccine':
        return Icons.vaccines_rounded;
      case 'flu':
      case 'influenza':
        return Icons.sick_rounded;
      case 'water':
        return Icons.water_drop_rounded;
      default:
        return Icons.health_and_safety_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientStart, gradientEnd],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    advisory.category?.isNotEmpty == true
                        ? advisory.category!.toUpperCase()
                        : 'SMC ADVISORY',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  advisory.title,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  advisory.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                        height: 1.4,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              _iconForCategory(advisory.category),
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
