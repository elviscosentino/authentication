import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.onPressed,
    required this.text,
    this.isThinking = false,
  });
  final VoidCallback onPressed;
  final String text;
  final bool isThinking;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.all(8.0)
        //shape: ShapeBorder()
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isThinking
          ? const SizedBox(width: 29, height: 29, child: CircularProgressIndicator(color: Colors.white))
          : Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white
            ),
          ),
        ],
      )
    );
  }
}
