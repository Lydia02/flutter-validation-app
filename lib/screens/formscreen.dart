import 'package:flutter/material.dart';
import 'secondscreen.dart'; // Import the second screen

// Global key to manage form state and validation
final _formKey = GlobalKey<FormState>();

/// This is the main form screen where users input their details.
class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  // Controllers to handle input values from text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  /// Email validation function:
  /// - Ensures input follows a valid email format.
  String? validateEmail(String? email) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty || !emailRegex.hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Phone validation function:
  /// - Ensures input starts with '+' followed by 10-15 digits.
  /// - Allows different country codes (e.g., +1, +44, +234).
  String? validatePhone(String? phone) {
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (phone == null || phone.isEmpty || !phoneRegex.hasMatch(phone)) {
      return 'Enter a valid phone number with country code (e.g., +2348123456789)';
    }
    return null;
  }

  /// Address validation function:
  /// - Ensures address is at least 5 characters long.
  String? validateAddress(String? address) {
    if (address == null || address.isEmpty || address.length < 5) {
      return 'Address must be at least 5 characters';
    }
    return null;
  }

  /// Disposes controllers when the widget is removed from the widget tree.
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// Handles form submission:
  /// - Validates input fields.
  /// - Shows a pop-up confirmation dialog instead of a snackbar.
  /// - Navigates to the second screen after clicking "OK".
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String address = _addressController.text;

      // Show a confirmation dialog before navigating
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success", textAlign: TextAlign.center),
            content: const Text(
              "Form Submitted Successfully!",
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog

                    // Navigate to the second screen after pressing "OK"
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: name,
                          email: email,
                          phone: phone,
                          address: address,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("OK",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      appBar: AppBar(
        title: const Text("User Form"), // Title for the screen
        backgroundColor: Colors.teal, // Themed app bar color
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey, // Assign global key for form validation
            child: Column(
              children: [
                // Name Input Field
                buildInputField(
                  "Name",
                  "Enter your name",
                  _nameController,
                  Icons.person,
                      (value) {
                    if (value == null || value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15), // Spacing between fields

                // Email Input Field
                buildInputField(
                  "Email",
                  "Enter your email",
                  _emailController,
                  Icons.email,
                  validateEmail,
                ),
                const SizedBox(height: 15),

                // Phone Input Field
                buildInputField(
                  "Phone",
                  "Enter your phone number (e.g., +2348123456789)",
                  _phoneController,
                  Icons.phone,
                  validatePhone,
                ),
                const SizedBox(height: 15),

                // Address Input Field
                buildInputField(
                  "Address",
                  "Enter your address",
                  _addressController,
                  Icons.location_on,
                  validateAddress,
                ),
                const SizedBox(height: 25),

                // Submit Button
                ElevatedButton(
                  onPressed: _handleSubmit, // Call validation & submission logic
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Button color
                    foregroundColor: Colors.white, // Button text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)), // Rounded button
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// A helper function to build an input field with validation.
  /// - `label`: The label displayed above the field.
  /// - `hint`: Placeholder text inside the field.
  /// - `controller`: Controls text input.
  /// - `icon`: An icon displayed inside the field.
  /// - `validator`: Function for validating input.
  Widget buildInputField(
      String label,
      String hint,
      TextEditingController controller,
      IconData icon,
      String? Function(String?)? validator,
      ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label, // Field label
        hintText: hint, // Field hint text
        prefixIcon: Icon(icon, color: Colors.teal), // Icon inside the field
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), // Rounded border
      ),
      keyboardType: label == "Phone"
          ? TextInputType.phone // Allow numbers and `+`
          : TextInputType.text, // Default type
      validator: validator, // Attach validation function
    );
  }
}
