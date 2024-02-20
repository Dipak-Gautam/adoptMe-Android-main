import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;

// void showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }
showSnackBar(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Message'),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

void httpErrorHandel({
  required dio.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, response.data['msg']);
      break;
    case 500:
      showSnackBar(context, response.data['msg']);
      break;
    default:
      showSnackBar(context, response.data);
  }
}
