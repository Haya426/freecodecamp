import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FailedWidget extends StatelessWidget {
  const FailedWidget(
      {super.key, required this.errorMessage, required this.tryAgain});
  final String errorMessage;
  final Function() tryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(errorMessage),
        ),
        FilledButton(onPressed: tryAgain, child: const Text('Try Again!'))
      ],
    );
  }
}
