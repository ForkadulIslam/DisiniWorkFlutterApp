import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class OTPInputFields extends StatefulWidget {
  const OTPInputFields({super.key});

  @override
  _OTPInputFieldsState createState() => _OTPInputFieldsState();
}

class _OTPInputFieldsState extends State<OTPInputFields> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(6, (index) {
        return Container(
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1,
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff8b8b8b))
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff8b8b8b))
                ),
                hintText: 'Email Or User Name'
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                } else {
                  // Focus on the last input field
                  _focusNodes[index].unfocus();
                }
              }
            },
          ),
        );
      }),
    );
  }
}