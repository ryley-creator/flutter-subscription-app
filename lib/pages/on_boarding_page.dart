import 'package:flutter/material.dart';
import 'package:task/pages/paywall_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: const [
                  _OnboardingPage(
                    icon: Icons.rocket_launch,
                    title: "Welcome",
                    description: "Discover premium features and improve your experience.",
                  ),
                  _OnboardingPage(
                    icon: Icons.workspace_premium,
                    title: "Go Premium",
                    description: "Unlock all features with a monthly or yearly plan.",
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_dot(currentPage == 0), const SizedBox(width: 8), _dot(currentPage == 1)],
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage == 0) {
                      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
                    }
                  },
                  child: Text(currentPage == 0 ? "Next" : "Continue"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(color: active ? Colors.blue : Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingPage({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120),
          const SizedBox(height: 30),

          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),

          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
