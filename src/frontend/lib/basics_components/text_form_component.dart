import 'package:flutter/material.dart';
import 'package:frontend/basics_components/component_pattern.dart';
import 'package:frontend/basics_components/default_colors.dart';
import 'package:frontend/l10n/l10n_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFormComponent extends StatefulWidget {

  final TextEditingController controller;
  final String? Function(dynamic value)? validator;
  final String textLabel;
  final int flex;
  final MaskTextInputFormatter? formatter;
  final bool visible;

  const TextFormComponent(this.textLabel, this.controller,
      {super.key, this.flex = 10, this.formatter, this.visible = true, this.validator});

  @override
  State<StatefulWidget> createState() {
    return _TextFormComponentState();
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

  static final MaskTextInputFormatter cnpjFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  static String? cpfValidator(text) {
    var invalidMessage = L10nService.l10n().invalidField("CPF");
    var value = TextFormComponent.cpfFormatter.unmaskText(text);
    final regex = RegExp(r'[0-9]');
    if (value.length < 11) return invalidMessage;
    if (!regex.hasMatch(value)) return invalidMessage;

    var numbers = value.split('');
    var sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(numbers[i]) * (10-i);
    }

    var digit = 11 - (sum % 11) >= 10 ? 0 : 11 - (sum % 11);

    if (digit != int.parse(numbers[9])) return invalidMessage;

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(numbers[i]) * (11-i);
    }

    digit = 11 - (sum % 11) >= 10 ? 0 : 11 - (sum % 11);

    if (digit != int.parse(numbers[10])) return invalidMessage;

    return null;

  }

  static String? cnpjValidator(text) {
    var invalidMessage = L10nService.l10n().invalidField("CNPJ");
    var value = TextFormComponent.cnpjFormatter.unmaskText(text);
    final regex = RegExp(r'[0-9]');
    if (value.length < 14) return invalidMessage;
    if (!regex.hasMatch(value)) return invalidMessage;

    var numbers = value.split('');
    var sum = 0;
    var multiply = 2;
    for (int i = 11; i >= 0; i--) {
      sum += int.parse(numbers[i]) * multiply;
      multiply++;
      if (multiply == 10) {
        multiply = 2;
      }
    }

    var digit = 11 - (sum % 11) >= 10 ? 0 : 11 - (sum % 11);

    if (digit != int.parse(numbers[12])) return invalidMessage;

    sum = 0;
    multiply = 2;
    for (int i = 12; i >= 0; i--) {
      sum += int.parse(numbers[i]) * multiply;
      multiply++;
      if (multiply == 10) {
        multiply = 2;
      }
    }

    digit = 11 - (sum % 11) >= 10 ? 0 : 11 - (sum % 11);

    if (digit != int.parse(numbers[13])) return invalidMessage;

    return null;

  }

  static String? emptyValidator(value) {
    var isString = value is String;

    if (value == null || (isString && value.isEmpty)) {
      return L10nService.l10n().errorCannotBeEmpty;
    }
    return null;
  }
}

class _TextFormComponentState extends State<TextFormComponent> {

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Visibility(
        visible: widget.visible,
        child:
          Flexible(
            flex: widget.flex,
            child:
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextFormField(
                  style: _focusNode.hasFocus ?
                    ComponentPattern.focusedTextStyle : ComponentPattern.textStyle,
                  focusNode: _focusNode,
                  inputFormatters: widget.formatter != null ? [widget.formatter!] : [],
                  controller: widget.controller,
                  validator: widget.validator,
                  cursorColor: DefaultColors.secondaryColor,
                  decoration: InputDecoration(
                    labelText: widget.textLabel,
                    labelStyle: _focusNode.hasFocus ?
                      ComponentPattern.focusedTextStyle : ComponentPattern.textStyle,
                    enabledBorder: ComponentPattern.border,
                    border: ComponentPattern.border,
                    disabledBorder: ComponentPattern.border,
                    focusedBorder: ComponentPattern.focusedBorder,
                    errorBorder: ComponentPattern.errorBorder,
                    focusedErrorBorder: ComponentPattern.errorBorder,
                    errorStyle: ComponentPattern.errorTextStyle,
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  ),
                ),
              )
          ),
      );
  }
}