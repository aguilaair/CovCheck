import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/material.dart';

class ToastInvalidCert extends StatelessWidget {
  const ToastInvalidCert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).hintColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Theme.of(context).backgroundColor),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            S.of(context).invalidcert,
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        ],
      ),
    );
  }
}
