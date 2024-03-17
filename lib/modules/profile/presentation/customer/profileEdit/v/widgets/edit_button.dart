
import 'package:flutter/material.dart';

class EditButtonWidget extends StatelessWidget {
  final Function() onTap;

  final bool check;

  const EditButtonWidget({
    Key? key,
    required this.check,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF09184c),
              Color(0xFF51b3f4),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: check
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "save",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
