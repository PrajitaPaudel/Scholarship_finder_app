import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../../../../app/widget/text/bigtext.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isNetworkImage;
  final VoidCallback? onTap;

  const FeaturedCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isNetworkImage = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: isNetworkImage
                  //       ? Image.network(
                  //     imagePath,
                  //     height: 120,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   )
                  //       : Image.asset(
                  //     imagePath,
                  //     height: 120,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/background.jpg',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          
                          child: BigText(

                              padding: EdgeInsets.all(10),
                            text:title,color: Colors.white,size: 20, ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
