import 'package:flutter/material.dart';

class SuperPasswordField extends StatefulWidget {
  const SuperPasswordField(
      {this.controller,
        this.onTap,
        this.onChanged,
        this.readOnly = false,
        this.maxLength,
        this.hintText,
        this.label = '',
        this.keyboardType = TextInputType.text,
        Key? key})
      : super(key: key);

  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool readOnly;
  final int? maxLength;
  final String? hintText;
  final String label;
  final TextInputType keyboardType;

  @override
  State<SuperPasswordField> createState() => _SuperPasswordFieldState();
}

class _SuperPasswordFieldState extends State<SuperPasswordField> {
  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(widget.label,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Colors.grey
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                TextFormField(
                  controller: widget.controller,
                  style: Theme.of(context).textTheme.titleMedium,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  obscureText: isObscured,
                  obscuringCharacter: '*',
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? widget.label,
                    filled: false,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isObscured ? 'Show' : 'Hide',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        width:  isObscured ? 35 : 30,
                        height: 1,
                        // color: ColorPath.fieldBorderDark,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
