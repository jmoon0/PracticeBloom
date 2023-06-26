import 'package:flutter/material.dart';

class CTAButton extends StatelessWidget {
  final void Function() onTap;
  final String buttonText;
  final Color? textColor;
  final bool loading;
  final Color? buttonColor;

  const CTAButton({super.key, required this.onTap, required this.buttonText, required this.loading, this.textColor, this.buttonColor,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
        ));
  }
}
