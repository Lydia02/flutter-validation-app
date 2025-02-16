import 'package:flutter/material.dart';

/// This screen displays the submitted form details after validation.
/// It receives the form input data as parameters.
class SecondScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;

  /// Constructor to receive form data from the first screen.
  const SecondScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background for better visibility
      appBar: AppBar(
        title: const Text("Submitted Details"), // AppBar title
        backgroundColor: Colors.teal, // Themed color to match the first screen
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0), // Provides consistent padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
          children: [
            // Title text at the top
            const Text(
              "Your Submitted Details:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Adds spacing before displaying the data

            // Display each form field using a helper function
            buildDetailRow("Name", name),
            buildDetailRow("Email", email),
            buildDetailRow("Phone", phone),
            buildDetailRow("Address", address),

            const SizedBox(height: 40), // Adds spacing before the button

            // Back button to return to the form screen
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Pops the current screen from the stack
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Matches the app theme
                  foregroundColor: Colors.white, // White text color for contrast
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)), // Rounded button shape
                ),
                child: const Text("Back", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// This function builds a row for displaying a label and its corresponding value.
  /// - `title`: The label (e.g., "Name", "Email")
  /// - `value`: The user-submitted input data
  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Adds spacing between rows
      child: Row(
        children: [
          // Title Label
          Text(
            "$title: ",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),

          // Value Text (Expanded to avoid overflow issues)
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
              overflow: TextOverflow.ellipsis, // Prevents long text from breaking layout
            ),
          ),
        ],
      ),
    );
  }
}
