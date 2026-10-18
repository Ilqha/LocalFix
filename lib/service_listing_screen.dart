
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'service_details_screen.dart';
import 'profile_screen.dart';

class ServiceListingScreen extends StatefulWidget {
  const ServiceListingScreen({super.key});

  @override
  State<ServiceListingScreen> createState() =>
      _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> providers = [
    {
      'name': 'Arjun Kumar',
      'service': 'Plumbing',
      'description': 'Leak repairs, taps and pipes',
      'rating': '4.8',
      'reviews': '126',
      'price': '₹299',
      'experience': '8 yrs',
      'distance': '1.2 km',
      'available': 'Available',
      'verified': true,
      'icon': Icons.plumbing,
    },
    {
      'name': 'Rahul Sharma',
      'service': 'Electrical',
      'description': 'Wiring, lights and repairs',
      'rating': '4.6',
      'reviews': '84',
      'price': '₹249',
      'experience': '5 yrs',
      'distance': '2.4 km',
      'available': 'Today',
      'verified': true,
      'icon': Icons.electrical_services,
    },
    {
      'name': 'Imran Khan',
      'service': 'Carpentry',
      'description': 'Furniture and door repairs',
      'rating': '4.9',
      'reviews': '203',
      'price': '₹349',
      'experience': '11 yrs',
      'distance': '3.1 km',
      'available': 'Available',
      'verified': true,
      'icon': Icons.handyman,
    },
    {
      'name': 'Ayesha Patel',
      'service': 'Cleaning',
      'description': 'Home and kitchen cleaning',
      'rating': '4.7',
      'reviews': '95',
      'price': '₹199',
      'experience': '4 yrs',
      'distance': '1.8 km',
      'available': 'Today',
      'verified': true,
      'icon': Icons.cleaning_services,
    },
  ];

  List<Map<String, dynamic>> get filteredProviders {
    List<Map<String, dynamic>> result = providers.where((provider) {
      final query = _searchController.text.trim().toLowerCase();

      return provider['name']
              .toString()
              .toLowerCase()
              .contains(query) ||
          provider['service']
              .toString()
              .toLowerCase()
              .contains(query) ||
          provider['description']
              .toString()
              .toLowerCase()
              .contains(query);
    }).toList();

    if (selectedFilter == 'Top rated') {
      result.sort(
        (a, b) => double.parse(b['rating'])
            .compareTo(double.parse(a['rating'])),
      );
    } else if (selectedFilter == 'Nearest') {
      result.sort(
        (a, b) => double.parse(a['distance'].split(' ')[0])
            .compareTo(double.parse(b['distance'].split(' ')[0])),
      );
    } else if (selectedFilter == 'Today') {
      result = result
          .where((provider) => provider['available'] == 'Today')
          .toList();
    }

    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void showProviderProfile(Map<String, dynamic> provider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetailsScreen(provider: provider),
      ),
    );
  }

  void _goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  void _goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F4FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12345A),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LocalFix',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Text(
              'SERVICE PROVIDERS',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search by name or service',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 8,
                children: ['All', 'Top rated', 'Nearest', 'Today']
                    .map(
                      (filter) => ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        onSelected: (_) {
                          setState(() => selectedFilter = filter);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Find a local professional',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF12345A),
                      ),
                    ),
                  ),
                  Text('${filteredProviders.length} providers'),
                ],
              ),
            ),
            Expanded(
              child: filteredProviders.isEmpty
                  ? const Center(
                      child: Text('No matching providers found.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: filteredProviders.length,
                      itemBuilder: (context, index) {
                        final provider = filteredProviders[index];

                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 27,
                                      backgroundColor:
                                          const Color(0xFFDCE7FA),
                                      child: Icon(
                                        provider['icon'] as IconData,
                                        color: const Color(0xFF2864C8),
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider['name'].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${provider['service']} • '
                                            '${provider['experience']} experience',
                                            style: const TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            provider['description'].toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 17,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' ${provider['rating']} '
                                                  '(${provider['reviews']} reviews)',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          provider['available'].toString(),
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'From ${provider['price']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF12345A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    if (provider['verified'] == true)
                                      const Expanded(
                                        child: Text(
                                          '✓ Sample verified profile',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    else
                                      const Spacer(),
                                    Text(
                                      provider['distance'].toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        showProviderProfile(provider),
                                    child: const Text('View profile →'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF2864C8),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            _goHome();
          } else if (index == 1) {
            // Already on the Services screen.
          } else if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bookings screen will be added later.'),
              ),
            );
          } else if (index == 3) {
            _goToProfile();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
