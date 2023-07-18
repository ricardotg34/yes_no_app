import 'package:flutter/material.dart';

class MessageFieldBox extends StatefulWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final outlinedInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
          hintText: 'End your mseesage with a "?"',
          enabledBorder: outlinedInputBorder,
          focusedBorder: outlinedInputBorder,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.send_outlined,
              color: textController.text.isEmpty
                  ? Colors.amber
                  : Theme.of(context).primaryColor,
            ),
            onPressed: textController.value.text.isEmpty
                ? null
                : () {
                    final textValue = textController.value.text;
                    textController.clear();
                    widget.onValue(textValue);
                  },
          )),
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        widget.onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
      onChanged: (value) => {
        setState(
          () {},
        )
      },
      onTapOutside: (event) {
        focusNode.unfocus();
      },
    );
  }
}
