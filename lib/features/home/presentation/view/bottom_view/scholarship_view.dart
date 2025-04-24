import 'package:flutter/material.dart';

class ScholarshipView extends StatelessWidget {
  final List<Scholarship> scholarships = [
    Scholarship(
      name: 'Global Excellence Scholarship',
      description: 'A fully-funded scholarship for international students.',
      amount: 1000,
      deadline: '2023-12-31',
    ),
    Scholarship(
      name: 'Women in STEM Scholarship',
      description: 'Scholarships for women pursuing STEM careers.',
      amount: 2000,
      deadline: '2024-01-15',
    ),
    // Add more scholarships here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Scholarships',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 16),
            // Wrap the ListView.builder inside Expanded to prevent overflow
            Expanded(
              child: ListView.builder(
                itemCount: scholarships.length,
                itemBuilder: (context, index) {
                  final scholarship = scholarships[index];
                  return _buildScholarshipCard(scholarship);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScholarshipCard(Scholarship scholarship) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.7),
                      Colors.blue.withOpacity(0.7)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scholarship.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scholarship.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.monetization_on,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '\$${scholarship.amount}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Deadline: ${scholarship.deadline}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Apply Now action
                    },
                    child: const Text('Apply Now'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Scholarship {
  final String name;
  final String description;
  final int amount;
  final String deadline;

  Scholarship({
    required this.name,
    required this.description,
    required this.amount,
    required this.deadline,
  });
}
