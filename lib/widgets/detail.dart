import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({required this.detail, required this.title, Key? key})
      : super(key: key);

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          width: 10
          ,
        ),
        Expanded(
          child: Text(
            detail ?? S.of(context).unk,
            maxLines: 3,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}