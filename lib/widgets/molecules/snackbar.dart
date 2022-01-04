import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/material.dart';

void successSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            S.of(context).updateok,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color(0xff1BCA4C),
    ),
  );
}

void errorSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            S.of(context).updatefail,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}

void progressSnackbar(BuildContext context, int current, int total) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          SizedBox(
            width: Theme.of(context).iconTheme.size,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            S.of(context).updateok + " $current / $total",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color(0xff424242),
      elevation: 0,
      animation: null,
      duration: const Duration(days: 1),
    ),
  );
}
