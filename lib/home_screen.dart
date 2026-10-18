
import 'package:flutter/material.dart';
import 'service_listing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Plumbing', 'icon': Icons.plumbing},
      {'name': 'Electrical', 'icon': Icons.electrical_services},
      {'name': 'Cleaning', 'icon': Icons.cleaning_services},
      {'name': 'Carpentry', 'icon': Icons.handyman},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12345A),
        foregroundColor: Colors.white,
        title: const Text(
          'LocalFix',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Local Services • Trusted People • Happier Homes',
                style: TextStyle(
                  color: Color(0xFF12345A),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'What do you need help with?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF12345A),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onSubmitted: (_) => _openListing(context),
                decoration: InputDecoration(
                  hintText: 'Search for a service...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                'Service Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _openListing(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFDCE7F5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            size: 34,
                            color: const Color(0xFF1769D2),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 26),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2EEFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Find trusted local professionals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF12345A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explore services for your home in one place.',
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _openListing(context),
                      child: const Text('Explore Services'),
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

  void _openListing(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ServiceListingScreen(),
      ),
    );
  }
}
