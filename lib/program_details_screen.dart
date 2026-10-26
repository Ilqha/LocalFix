
import 'package:flutter/material.dart';
import 'booking_form_screen.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> provider;
  final int rank;

  const ProgramDetailsScreen({
    super.key,
    required this.provider,
    required this.rank,
  });

  static const Color teal = Color(0xFF008C8C);
  static const Color background = Color(0xFFF7F9FC);

  @override
  Widget build(BuildContext context) {
    final rating = (provider['rating'] as num?)?.toDouble() ?? 0.0;
    final reviews = (provider['reviewCount'] as num?)?.toInt() ?? 0;
    final verified = provider['verified'] == true;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Program Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Color(0xFFE0F2F1),
                    child: Icon(
                      Icons.person,
                      size: 48,
                      color: teal,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    provider['name']?.toString() ?? 'Provider',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    provider['service']?.toString() ?? 'Service',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        '$rating ($reviews reviews)',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: verified
                          ? const Color(0xFFE0F2F1)
                          : const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          verified ? Icons.verified : Icons.info_outline,
                          size: 18,
                          color: verified ? teal : Colors.orange,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          verified ? 'Verified Provider' : 'Not Verified',
                          style: TextStyle(
                            color: verified ? teal : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Provider Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _detailRow(
              Icons.emoji_events_outlined,
              'Provider Rank',
              '#$rank',
            ),
            _detailRow(
              Icons.phone_outlined,
              'Phone',
              provider['phone']?.toString() ?? 'Not provided',
            ),
            _detailRow(
              Icons.location_on_outlined,
              'Location',
              provider['area']?.toString() ?? 'Not provided',
            ),
            _detailRow(
              Icons.work_outline,
              'Experience',
              '${provider['experienceYears'] ?? 0} years',
            ),
            _detailRow(
              Icons.check_circle_outline,
              'Completed Jobs',
              '${provider['completedJobs'] ?? 0}',
            ),

            const SizedBox(height: 24),

            const Text(
              'About This Service',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                provider['description']?.toString() ??
                    'No description available.',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingFormScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: teal, size: 23),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
