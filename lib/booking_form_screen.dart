import 'package:flutter/material.dart';

class BookingFormScreen extends StatefulWidget {
const BookingFormScreen({super.key});
  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  // Global key for form validation state
  final _formKey = GlobalKey<FormState>();

  // Text controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Selected dropdown value for Service Category
  String? _selectedCategory = 'Plumbing';
  final List<String> _categories = [
    'Plumbing',
    'Electrical',
    'Carpentry',
    'Cleaning',
    'Appliance Repair',
  ];

  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Form Submission Handler
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show Green Success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Booking Request Submitted Successfully!',
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

      // Return to Home or Booking History after short delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    } else {
      // Show Red Error Alert SnackBar if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Please correct the highlighted errors before submitting.',
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
          'Book LocalFix Service',
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
                // Section Header Banner
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
                          Icons.home_repair_service_rounded,
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
                              'Request Household Repair',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Fill out the details to get matched with verified local technicians.',
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
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _buildInputDecoration(
                    hintText: 'e.g. John Doe',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters long';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // 2. Phone Number Field
                const Text(
                  'Phone Number *',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration(
                    hintText: 'e.g. +91 98765 43210',
                    prefixIcon: Icons.phone_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your contact phone number';
                    }
                    if (!RegExp(r'^[0-9+\s-]{8,15}$').hasMatch(value.trim())) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // 3. Service Category Dropdown
                const Text(
                  'Service Category *',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
initialValue: _selectedCategory,                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: _buildInputDecoration(
                    hintText: 'Select service type',
                    prefixIcon: Icons.build_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a service category';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // 4. Service Location Address Field
                const Text(
                  'Service Address / Location *',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _addressController,
                  maxLines: 2,
                  decoration: _buildInputDecoration(
                    hintText: 'Enter street address, building, or landmark',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the service address';
                    }
                    if (value.trim().length < 8) {
                      return 'Please provide a detailed address for the technician';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // 5. Preferred Service Date Field
                const Text(
                  'Preferred Service Date *',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: _buildInputDecoration(
                    hintText: 'Select date',
                    prefixIcon: Icons.calendar_today_outlined,
                    suffixIcon: Icons.arrow_drop_down,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select a preferred service date';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // 6. Problem Description Field
                const Text(
                  'Issue Description *',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: _buildInputDecoration(
                    hintText: 'Describe the issue (e.g. leaking kitchen pipe under the sink)',
                    prefixIcon: Icons.description_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide a short description of the issue';
                    }
                    if (value.trim().length < 10) {
                      return 'Description must be at least 10 characters long';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 28),

                // 7. Submit Request CTA Button
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit Booking Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  // Reusable Input Field Decoration Helper
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF94A3B8)),
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: const Color(0xFF94A3B8))
          : null,
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
      ),
    );
  }
}

