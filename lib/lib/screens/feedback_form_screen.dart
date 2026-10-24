import 'package:flutter/material.dart';

class FeedbackFormScreen extends StatefulWidget {
const FeedbackFormScreen({super.key});  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  // Rating & Service Type selection
  double _rating = 5.0;
  String? _selectedService = 'Plumbing';
  final List<String> _services = [
    'Plumbing',
    'Electrical',
    'Carpentry',
    'Cleaning',
    'General Query',
  ];

  bool _isSubmitting = false;

  String? get _selectedCategory => null;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  // Backend / Data Submission Handler (Simulated API Call)
  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Prepare payload JSON structure for Backend API integration
      final Map<String, dynamic> feedbackData = {
        'userName': _nameController.text.trim(),
        'userEmail': _emailController.text.trim(),
        'serviceCategory': _selectedService,
        'rating': _rating,
        'comments': _commentsController.text.trim(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Simulate a backend network POST request delay (e.g. REST API / Firebase)
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      // Print backend payload to console for verification
      debugPrint("Backend Submission Payload: $feedbackData");

      // Show Success Toast / SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Feedback submitted successfully to LocalFix server!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF16A34A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      // Reset Form fields
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _commentsController.clear();
      setState(() {
        _rating = 5.0;
        _selectedService = 'Plumbing';
      });
    } else {
      // Show Error SnackBar if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Please correct highlighted errors before submitting.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'LocalFix Service Feedback',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Banner Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2563EB),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.rate_review_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Share Your Experience',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Your feedback helps us verify handymen and improve service quality.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF3B82F6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 1. Full Name Field
                const Text(
                  'Full Name *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration('Enter your full name', Icons.person_outline_rounded),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // 2. Email Address Field
                const Text(
                  'Email Address *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration('Enter your email address', Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // 3. Service Category Dropdown
                const Text(
                  'Service Used *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  items: _services
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedService = val),
                  decoration: _inputDecoration('Select service category', Icons.build_outlined),
                  validator: (value) => value == null ? 'Please select a service' : null,
                ),
                const SizedBox(height: 18),

                // 4. Rating Slider
                Text(
                  'Satisfaction Rating: ${_rating.toInt()} / 5 Stars',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 6),
                Slider(
                  value: _rating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: const Color(0xFF2563EB),
                  label: '${_rating.toInt()} Stars',
                  onChanged: (val) => setState(() => _rating = val),
                ),
                const SizedBox(height: 18),

                // 5. Comments Field
                const Text(
                  'Feedback & Comments *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _commentsController,
                  maxLines: 4,
                  decoration: _inputDecoration('Describe your experience or suggestion...', Icons.chat_bubble_outline_rounded),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide your feedback comments';
                    }
                    if (value.trim().length < 10) {
                      return 'Comments must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // Submit Button
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Submit Feedback',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData prefixIcon) {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF94A3B8)),
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5)),
    );
  }
}

