
import 'package:flutter/material.dart';

class CircularFilePicker extends StatelessWidget {
  final String? fileName;
  final VoidCallback onPickFile;

  const CircularFilePicker({
    super.key,
    required this.fileName,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickFile, // Ensures tapping opens the file picker
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1.5),
        ),
        child: Row(
          children: [
            const Icon(Icons.attach_file, color:Color.fromRGBO(13, 71, 200, 0.9)),
            SizedBox(width: 5,),
            Text(
              fileName ?? "Select a file",
              maxLines: 1,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',

                color: fileName == null ? Colors.grey.shade600 : Colors.black,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
