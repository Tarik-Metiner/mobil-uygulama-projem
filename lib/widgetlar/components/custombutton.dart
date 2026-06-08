import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final IconData? icon;

  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed:
            isLoading ? null : onPressed,

        icon: isLoading
            ? Container(
                width: 20,
                height: 20,
                margin:
                    const EdgeInsets.only(
                        right: 8),
                child:
                    const CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Icon(
                icon ?? Icons.check,
              ),

        label: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        style: ElevatedButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(
            vertical: 15,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }
}