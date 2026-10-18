
import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? provider;

  const ServiceDetailsScreen({
    super.key,
    this.provider,
  });

  static const navy = Color(0xFF12345A);
  static const blue = Color(0xFF1769D2);
  static const background = Color(0xFFE5F4FA);

  @override
  Widget build(BuildContext context) {
    final data = provider ??
        <String, dynamic>{
          'name': 'Local Service Provider',
          'service': 'Plumbing',
          'description': 'Reliable household services',
          'rating': '4.5',
          'reviews': '0',
          'price': '₹299',
          'experience': 'Experienced professional',
          'distance': 'Nearby',
          'available': 'By appointment',
          'verified': false,
          'icon': Icons.home_repair_service,
        };

    final serviceIcon = data['icon'] is IconData
        ? data['icon'] as IconData
        : Icons.home_repair_service;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Service Details'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: const Color(0xFFD7EAFE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(serviceIcon, size: 70, color: blue),
                  const SizedBox(height: 14),
                  Text(
                    '${data['service']} Service',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['description']?.toString() ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Provider Information',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFC5DDF8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFFD7EAFE),
                        child: Icon(
                          Icons.person,
                          size: 34,
                          color: blue,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name']?.toString() ?? 'Provider',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: navy,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${data['experience']} experience',
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28),
                  _infoRow(
                    Icons.star,
                    '${data['rating']} / 5 (${data['reviews']} reviews)',
                    iconColor: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    Icons.location_on_outlined,
                    data['distance']?.toString() ?? 'Nearby',
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    Icons.access_time,
                    'Availability: ${data['available']}',
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    Icons.verified_outlined,
                    data['verified'] == true
                        ? 'Verified profile'
                        : 'Verification not confirmed',
                    iconColor: data['verified'] == true
                        ? Colors.green
                        : Colors.blueGrey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Starting Price',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['price']?.toString() ?? 'Contact for price',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sample listing price; actual cost may vary.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Contact functionality will be added later.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.phone_outlined),
                label: const Text('Contact Provider'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoRow(
    IconData icon,
    String text, {
    Color iconColor = blue,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 21),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
