import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFormComponent extends StatelessWidget {

  final TextEditingController controller;
  final String? Function(dynamic value)? validator;
  final String textLabel;
  final int flex;
  final MaskTextInputFormatter? formatter;
  final bool visible;

  const TextFormComponent(this.textLabel, this.controller, {super.key, this.flex = 10, this.formatter, this.visible = true, this.validator});

  @override
  Widget build(BuildContext context) {
    return
      Visibility(
        visible: visible,
        child:
          Flexible(
            flex: flex,
            child:
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextFormField(
                  inputFormatters: formatter != null ? [formatter!] : [],
                  controller: controller,
                  validator: validator,
                  decoration: InputDecoration(
                    labelText: textLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
              )
          ),
      );
  }

  static final MaskTextInputFormatter postalCodeFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  static final MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '(##)# ####-####',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  static final MaskTextInputFormatter cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  static String? cpfValidator(text) {
    var value = TextFormComponent.cpfFormatter.unmaskText(text);
    final regex = RegExp(r'[0-9]');
    if (value.length < 11) return "cpf Inválido";
    if (!regex.hasMatch(value)) return "cpf Inválido";

    var numbers = value.split('');
    var sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(numbers[i]) * (10-i);
    }

    var digit = 11 - (sum % 11) >= 10 ? 0 : 11 - (sum % 11);

    if (digit != int.parse(numbers[9])) return "Cpf Inválido";

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(numbers[i]) * (11-i);
    }

    digit = 11 - (sum % 11) >= 10 ? 0 : 11 - (sum % 11);

    if (digit != int.parse(numbers[10])) return "Cpf Inválido";

    return null;

  }

}