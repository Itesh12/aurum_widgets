import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// A data model for each slide in the AurumOnboardingPager.
class AurumOnboardingContent {
  final String title;
  final String description;
  final String imagePath;
  final Widget? customWidget;

  const AurumOnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
    this.customWidget,
  });
}

/// A premium onboarding pager that wraps PageView and SmoothPageIndicator.
/// Features smooth transitions and pre-styled content layouts.
class AurumOnboardingPager extends StatefulWidget {
  final List<AurumOnboardingContent> contents;
  final VoidCallback onFinish;
  final String skipText;
  final String nextText;
  final String finishText;
  final PageController? controller;

  const AurumOnboardingPager({
    super.key,
    required this.contents,
    required this.onFinish,
    this.skipText = "Skip",
    this.nextText = "Next",
    this.finishText = "Get Started",
    this.controller,
  });

  @override
  State<AurumOnboardingPager> createState() => _AurumOnboardingPagerState();
}

class _AurumOnboardingPagerState extends State<AurumOnboardingPager> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.controller ?? PageController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.contents.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = widget.contents[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: item.customWidget ??
                          Image.asset(
                            item.imagePath,
                            fit: BoxFit.contain,
                          ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).hintColor,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: widget.onFinish,
                child: Text(
                  widget.skipText,
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: widget.contents.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: colorScheme.primary,
                  // ignore: deprecated_member_use
                  dotColor: colorScheme.primary.withOpacity(0.2),
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 4,
                ),
              ),
              IconButton.filled(
                onPressed: () {
                  if (_currentIndex < widget.contents.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    widget.onFinish();
                  }
                },
                icon: Icon(
                  _currentIndex < widget.contents.length - 1
                      ? Icons.arrow_forward_ios
                      : Icons.check,
                  size: 18,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
