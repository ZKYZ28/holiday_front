import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericInputField<BlocType extends BlocBase<StateType>, StateType>
    extends StatelessWidget {
  final bool Function(StateType previous, StateType current) buildWhen;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final void Function(String) onChanged;
  final String? Function(StateType state) errorText;
  final String? initialValue;

  const GenericInputField({
    super.key,
    required this.buildWhen,
    required this.labelText,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    required this.onChanged,
    required this.errorText,
    this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocType, StateType>(
      buildWhen: buildWhen,
      builder: (context, state) {
        return TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              border: const OutlineInputBorder(),
              errorText: errorText(state),
              errorMaxLines: 10,
            ),
            keyboardType: keyboardType,
            obscureText: isPassword,
            onChanged: onChanged);
      },
    );
  }
}
