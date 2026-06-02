import 'package:flutter/material.dart';
import 'package:task/pages/home_page.dart';
import 'package:task/service/storage_service.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int selectedPlan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Premium")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Text("Choose your plan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            const SizedBox(height: 30),

            _planCard(title: "Monthly", price: "\$4.99", index: 0),

            const SizedBox(height: 16),

            _planCard(title: "Yearly", price: "\$29.99", subtitle: "Save 50%", index: 1),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Confirm Purchase"),
                        content: Text(selectedPlan == 0 ? "Purchase Monthly Plan?" : "Purchase Yearly Plan?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await StorageService.saveSubscription();
                              if (!context.mounted) return;
                              Navigator.pop(context);

                              _showSuccessDialog();
                            },
                            child: const Text("Purchase"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("You're Pro Now!"),
          content: const Text("Your premium subscription has been activated."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: Text("Continue", style: TextStyle(fontSize: 17, color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Widget _planCard({required String title, required String price, required int index, String? subtitle}) {
    final isSelected = selectedPlan == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPlan = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: isSelected ? Colors.blue : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                ],
              ),
            ),

            Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
