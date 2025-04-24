
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ScholarshipProviderCard extends StatelessWidget {
  final String name;
  final String? location;
  final int scholarshipCount;
  final String? imagePath;
  final double elevation;
  final double borderRadius;
  final Color overlayColor;
  final VoidCallback onTap;

  const ScholarshipProviderCard({super.key,

    required this.name,
    this.location,
    required this.scholarshipCount,
     this.imagePath,
    this.elevation = 6.0,
    this.borderRadius = 12.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.4),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child:
                // imagePath != null
                //     ? Image.network(
                //   imagePath!,
                //   fit: BoxFit.cover,
                //   color: overlayColor,
                //   colorBlendMode: BlendMode.darken,
                // )
                //     : Image.asset(
                //   'assets/images/unit1.jpg',
                //   fit: BoxFit.cover,
                //   color: overlayColor,
                //   colorBlendMode: BlendMode.darken,
                // ),
                       Image.asset(
                         'assets/images/mit.jpg',
                  fit: BoxFit.cover,
                  color: overlayColor,
                  colorBlendMode: BlendMode.darken,
                ),
              ),

              // Content Overlay
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      location ?? "Unknown Location",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Available Scholarships: $scholarshipCount',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
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
}
