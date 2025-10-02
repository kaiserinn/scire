import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scire/routing/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  bool _isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _isLastPage = index == 3;
              });
            },
            children: const [
              OnboardingPage(
                icon: Icons.style,
                title: 'Effective Review',
                subtitle:
                    'Review material with a Spaced Repetition System for long-term memory.',
              ),
              OnboardingPage(
                icon: Icons.inventory_2,
                title: 'Manage Your Card Collections',
                subtitle:
                    'Easily create, edit, and organize all your decks and flashcards in one place.',
              ),
              OnboardingPage(
                icon: Icons.import_export,
                title: 'Import & Export Decks',
                subtitle:
                    'Share your own decks or study material from others with the import/export feature.',
              ),
              SyncAndActionPage(),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: _isLastPage
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _pageController.jumpToPage(3),
                        child: const Text('SKIP'),
                      ),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                        style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120, color: Theme.of(context).primaryColor),
          const SizedBox(height: 48),
          Text(
            title,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SyncAndActionPage extends StatelessWidget {
  const SyncAndActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.sync, size: 120, color: Theme.of(context).primaryColor),
          const SizedBox(height: 48),
          Text(
            'Sync Your Progress',
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Save your learning progress to the cloud and continue on any device.',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),

          FilledButton(
            onPressed: () {
              context.go(Routes.auth);
            },
            style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
            child: const Text('Login or Register'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              context.go(Routes.home);
            },
            child: const Text('Continue without an account'),
          ),
        ],
      ),
    );
  }
}
