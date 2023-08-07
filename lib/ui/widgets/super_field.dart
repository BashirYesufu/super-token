import 'package:flutter/material.dart';

class SuperField extends StatefulWidget {
  const SuperField({
    this.controller,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.readOnly = false,
    this.isCurrency = false,
    this.maxLength,
    this.hintText,
    this.onCard = false,
    this.enabled = true,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.padding,
    this.maxLines = 1,
    Key? key
  }) : super(key: key);

  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final bool readOnly;
  final bool isCurrency;
  final bool onCard;
  final bool enabled;
  final int? maxLength;
  final String? hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final TextInputType keyboardType;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final int maxLines;

  @override
  State<SuperField> createState() => _SuperFieldState();
}

class _SuperFieldState extends State<SuperField> {
  bool get isDark  => Theme.of(context).brightness == Brightness.dark;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.isNotEmpty ? Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
              widget.label,
              style: Theme.of(context).textTheme.titleMedium
          ),
        ) :  SizedBox(),
        Container(
          height: 48 * widget.maxLines.toDouble(),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey
            )
          ),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              controller: widget.controller,
              style: Theme.of(context).textTheme.titleMedium,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComplete,
              readOnly: widget.readOnly,
              textCapitalization: TextCapitalization.none,
              cursorColor: Colors.grey,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                counterText: '',
                hintText: widget.hintText ?? widget.label,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                filled: false,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
