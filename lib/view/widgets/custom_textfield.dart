import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.keyboard,
    this.isThinking = false,
    this.onSaved,
    this.onChanged,
    this.focusNode,
    this.formFieldKey,
    // required this.textEditingController,
    // this.isPass = false,
    // required this.hintText,
    // required this.icon,
    //required this.textInputType
  });

  final IconData icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final GlobalKey<FormFieldState>? formFieldKey;
  final bool isThinking;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObscure = false;
  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboard,
        obscureText: widget.isSecret,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Icon(widget.icon, color: Colors.black45),
          suffixIcon: widget.isSecret
            ? IconButton(
              onPressed: (){setState((){isObscure = !isObscure;});},
              icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off)
            )
            : widget.isThinking ? Transform.scale(scale: 0.5, child: const CircularProgressIndicator()) : null,
          labelText: widget.label,
          alignLabelWithHint: true,
          isDense: true,
          //hintText: 'sdfsdfsdfdsf',
          // hintStyle: const TextStyle(
          //   color: Colors.black45,
          //   fontSize: 18
          // ),
          //border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFFedf0f8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: Colors.black45),
            //borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.blue
            ),
            borderRadius: BorderRadius.circular(18)
          ),
        ),
      ),
    );
  }
}
