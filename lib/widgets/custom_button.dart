import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.type,
      required this.onPressed,
      required this.isLoading});

  final String text;
  final String type;
  final dynamic onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      color: type == 'primary' ? Colors.white : Colors.black87),
                ),
          style: ElevatedButton.styleFrom(
            primary: type == 'primary'
                ? Colors.blueAccent
                : Colors.white60.withOpacity(0.8),
            onPrimary: Colors.black12,
            side: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
