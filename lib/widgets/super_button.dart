import 'package:flutter/material.dart';
import 'package:super_token/constant/super_color.dart';

class SuperButton extends StatelessWidget {
  final String? label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const SuperButton({
    this.onTap,
    this.label,
    this.textColor = Colors.white,
    this.backgroundColor = SuperColor.primaryColor,
    this.borderColor,
    this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Material(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: borderColor ?? backgroundColor,
                width: 1.0,
              )
          ),
          child: MaterialButton(
            splashColor: backgroundColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: onTap,
            minWidth: double.infinity,
            height: 48,
            child: child ?? Text(
              label ?? '',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}