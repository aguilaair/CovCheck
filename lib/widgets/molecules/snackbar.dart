import 'package:covid_checker/generated/l10n.dart';
import 'package:flutter/material.dart';

void successSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
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
      dismissDirection: DismissDirection.horizontal,
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

void progressSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      content: Row(
        children: [
          SizedBox(
            width: ((Theme.of(context).iconTheme.size ?? 24)),
            height: ((Theme.of(context).iconTheme.size ?? 24)),
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            S.of(context).updatingdata,
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
      duration: const Duration(days: 1),
    ),
  );
}

Future<void> doTaskOnSnackbar(BuildContext context, Function func) async {
  ScaffoldMessenger.of(context).clearSnackBars();
  progressSnackbar(context);
  try {
    await func();
    ScaffoldMessenger.of(context).clearSnackBars();
    successSnackbar(context);
  } catch (e) {
    ScaffoldMessenger.of(context).clearSnackBars();
    errorSnackbar(context);
  }
}
