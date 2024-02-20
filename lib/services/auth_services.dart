// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exports.dart';
import 'package:dio/dio.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('name', "");
      User user = User(
        id: '',
        username: username,
        email: email,
        token: '',
        password: password,
        isVerified: '',
      );
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post(
        '${Constants.uri}/authuser/signup',
        data: user.toJson(),
      );
      String uEmail = response.data['email'];
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EmailVerification(
                email: uEmail,
              )));
      // switch (response.statusCode) {
      //   case 200:
      //     String uEmail = response.data['email'];
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //         builder: (context) => EmailVerification(
      //               email: uEmail,
      //             )));
      //     break;
      //   case 400:
      //     showDialog(
      //         context: context,
      //         builder: (ctx) => AlertDialog(
      //               title: const Text("Error"),
      //               content: Text(response.data['msg'].toString()),
      //               actions: <Widget>[
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(ctx).pop();
      //                   },
      //                   child: Container(
      //                     color: Colors.green,
      //                     padding: const EdgeInsets.all(14),
      //                     child: const Text("OK"),
      //                   ),
      //                 ),
      //               ],
      //             ));
      //     // showAboutDialog(
      //     //     context: context,
      //     //     applicationName: "AdoptMe Error",
      //     //     children: [Text(response.data['msg'])]);
      //     //  showSnackBar(context, response.data['msg']);
      //     break;
      //   case 500:
      //     showAboutDialog(
      //         context: context,
      //         applicationName: "AdoptMe Error",
      //         children: [Text(response.data['msg'])]);
      //     //showSnackBar(context, response.data['msg']);
      //     break;
      //   default:
      //     //showSnackBar(context, response.data);
      //     showAboutDialog(
      //         context: context,
      //         applicationName: "AdoptMe Error",
      //         children: [Text(response.data)]);
      // }
      // httpErrorHandel(
      //     response: response,
      //     context: context,
      //     onSuccess: () {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //           builder: (context) => EmailVerification(
      //                 email: uEmail,
      //               )));
      //     });
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }
  }

  void signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      Dio dio = Dio();
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      final User user = User(
          id: '',
          username: username,
          email: '',
          token: '',
          password: password,
          isVerified: '');
      dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post('${Constants.uri}/authuser/signin',
          data: user.toJson());
      if (response.data['isVerified'] == "true") {
        if (response.data['isDetails'] == "no") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('_uid', response.data['_id']);
          prefs.setString('uEmail', response.data['email']);
          String uEmail = response.data['email'];
          // userProvider.setUser(response.toString());
          // await prefs.setString('x-auth-token', response.data['token']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => EnterUserDetails(
                email: uEmail,
              ),
            ),
            (route) => false,
          );
        }
        if (response.data['isDetails'] == "yes") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('_uid', response.data['_id']);
          prefs.setString('uEmail', response.data['email']);
          userProvider.setUser(response.toString());
          await prefs.setString('x-auth-token', response.data['token']);
          String? name = prefs.getString('name');
          String? uid = response.data['_id'];
          final data = {'uid': uid};
          // Response responseP = await Dio()
          //     .post("${Constants.uri}/user/details", data: data);

          prefs.setString('name', response.data['name']);
          prefs.setString('address', response.data['address']);
          prefs.setString('phone', response.data['phone']);
          prefs.setString('mobile', response.data['mobile']);
          prefs.setString('imageUser', response.data['image']);
          print(prefs.getString('name'));
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false,
          );
        }
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('_uid', response.data['_id']);
        // prefs.setString('uEmail', response.data['email']);
        // userProvider.setUser(response.toString());
        // await prefs.setString('x-auth-token', response.data['token']);
        // String? name = prefs.getString('name');
        // String uEmail = response.data['email'];
        // if (name == null) {
        //   navigator.pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => EnterUserDetails(
        //         email: uEmail,
        //       ),
        //     ),
        //     (route) => false,
        //   );
        // } else {
        //   print(name);
        //   navigator.pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => HomePage(),
        //     ),
        //     (route) => false,
        //   );
        // }
      } else {
        String uEmail = response.data['email'];
        httpErrorHandel(
            response: response,
            context: context,
            onSuccess: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => EmailVerification(
                        email: uEmail,
                      )));
            });
      }
      // switch (response.statusCode) {
      //   case 200:
      //     if (response.data['isVerified'] == "true") {
      //       if (response.data['isDetails'] == "no") {
      //         SharedPreferences prefs = await SharedPreferences.getInstance();
      //         prefs.setString('_uid', response.data['_id']);
      //         prefs.setString('uEmail', response.data['email']);
      //         String uEmail = response.data['email'];
      //         // userProvider.setUser(response.toString());
      //         // await prefs.setString('x-auth-token', response.data['token']);
      //         navigator.pushAndRemoveUntil(
      //           MaterialPageRoute(
      //             builder: (context) => EnterUserDetails(
      //               email: uEmail,
      //             ),
      //           ),
      //           (route) => false,
      //         );
      //       }
      //       if (response.data['isDetails'] == "yes") {
      //         SharedPreferences prefs = await SharedPreferences.getInstance();
      //         prefs.setString('_uid', response.data['_id']);
      //         prefs.setString('uEmail', response.data['email']);
      //         userProvider.setUser(response.toString());
      //         await prefs.setString('x-auth-token', response.data['token']);
      //         String? name = prefs.getString('name');
      //         String? uid = response.data['_id'];
      //         final data = {'uid': uid};
      //         // Response responseP = await Dio()
      //         //     .post("${Constants.uri}/user/details", data: data);

      //         prefs.setString('name', response.data['name']);
      //         prefs.setString('address', response.data['address']);
      //         prefs.setString('phone', response.data['phone']);
      //         prefs.setString('mobile', response.data['mobile']);
      //         prefs.setString('imageUser', response.data['image']);
      //         print(prefs.getString('name'));
      //         navigator.pushAndRemoveUntil(
      //           MaterialPageRoute(
      //             builder: (context) => HomePage(),
      //           ),
      //           (route) => false,
      //         );
      //       }
      //       // SharedPreferences prefs = await SharedPreferences.getInstance();
      //       // prefs.setString('_uid', response.data['_id']);
      //       // prefs.setString('uEmail', response.data['email']);
      //       // userProvider.setUser(response.toString());
      //       // await prefs.setString('x-auth-token', response.data['token']);
      //       // String? name = prefs.getString('name');
      //       // String uEmail = response.data['email'];
      //       // if (name == null) {
      //       //   navigator.pushAndRemoveUntil(
      //       //     MaterialPageRoute(
      //       //       builder: (context) => EnterUserDetails(
      //       //         email: uEmail,
      //       //       ),
      //       //     ),
      //       //     (route) => false,
      //       //   );
      //       // } else {
      //       //   print(name);
      //       //   navigator.pushAndRemoveUntil(
      //       //     MaterialPageRoute(
      //       //       builder: (context) => HomePage(),
      //       //     ),
      //       //     (route) => false,
      //       //   );
      //       // }
      //     } else {
      //       String uEmail = response.data['email'];
      //       httpErrorHandel(
      //           response: response,
      //           context: context,
      //           onSuccess: () {
      //             Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                 builder: (context) => EmailVerification(
      //                       email: uEmail,
      //                     )));
      //           });
      //     }
      //     break;
      //   case 400:
      //     showDialog(
      //         context: context,
      //         builder: (ctx) => AlertDialog(
      //               title: const Text("Error"),
      //               content: Text(response.data["msg"]),
      //               actions: <Widget>[
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(ctx).pop();
      //                   },
      //                   child: Container(
      //                     color: Colors.green,
      //                     padding: const EdgeInsets.all(14),
      //                     child: const Text("OK"),
      //                   ),
      //                 ),
      //               ],
      //             ));
      //     //showSnackBar(context, response.data['msg']);
      //     break;
      //   case 500:
      //     showSnackBar(context, response.data['msg']);
      //     break;
      //   default:
      //     showSnackBar(context, response.data);
      // }
      // httpErrorHandel(
      //     response: response,
      //     context: context,
      //     onSuccess: () async {
      //       if (response.data['isVerified'] == "true") {
      //         if (response.data['isDetails'] == "no") {
      //           SharedPreferences prefs = await SharedPreferences.getInstance();
      //           prefs.setString('_uid', response.data['_id']);
      //           prefs.setString('uEmail', response.data['email']);
      //           String uEmail = response.data['email'];
      //           // userProvider.setUser(response.toString());
      //           // await prefs.setString('x-auth-token', response.data['token']);
      //           navigator.pushAndRemoveUntil(
      //             MaterialPageRoute(
      //               builder: (context) => EnterUserDetails(
      //                 email: uEmail,
      //               ),
      //             ),
      //             (route) => false,
      //           );
      //         }
      //         if (response.data['isDetails'] == "yes") {
      //           SharedPreferences prefs = await SharedPreferences.getInstance();
      //           prefs.setString('_uid', response.data['_id']);
      //           prefs.setString('uEmail', response.data['email']);
      //           userProvider.setUser(response.toString());
      //           await prefs.setString('x-auth-token', response.data['token']);
      //           String? name = prefs.getString('name');
      //           String? uid = response.data['_id'];
      //           final data = {'uid': uid};
      //           // Response responseP = await Dio()
      //           //     .post("${Constants.uri}/user/details", data: data);

      //           prefs.setString('name', response.data['name']);
      //           prefs.setString('address', response.data['address']);
      //           prefs.setString('phone', response.data['phone']);
      //           prefs.setString('mobile', response.data['mobile']);
      //           prefs.setString('imageUser', response.data['image']);
      //           print(prefs.getString('name'));
      //           navigator.pushAndRemoveUntil(
      //             MaterialPageRoute(
      //               builder: (context) => HomePage(),
      //             ),
      //             (route) => false,
      //           );
      //         }
      //         // SharedPreferences prefs = await SharedPreferences.getInstance();
      //         // prefs.setString('_uid', response.data['_id']);
      //         // prefs.setString('uEmail', response.data['email']);
      //         // userProvider.setUser(response.toString());
      //         // await prefs.setString('x-auth-token', response.data['token']);
      //         // String? name = prefs.getString('name');
      //         // String uEmail = response.data['email'];
      //         // if (name == null) {
      //         //   navigator.pushAndRemoveUntil(
      //         //     MaterialPageRoute(
      //         //       builder: (context) => EnterUserDetails(
      //         //         email: uEmail,
      //         //       ),
      //         //     ),
      //         //     (route) => false,
      //         //   );
      //         // } else {
      //         //   print(name);
      //         //   navigator.pushAndRemoveUntil(
      //         //     MaterialPageRoute(
      //         //       builder: (context) => HomePage(),
      //         //     ),
      //         //     (route) => false,
      //         //   );
      //         // }
      //       } else {
      //         String uEmail = response.data['email'];
      //         httpErrorHandel(
      //             response: response,
      //             context: context,
      //             onSuccess: () {
      //               Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                   builder: (context) => EmailVerification(
      //                         email: uEmail,
      //                       )));
      //             });
      //       }
      //     });
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['x-auth-token'] = token!;
      var tokenRes = await dio.get(
        '${Constants.uri}/authuser/tokenValid',
      );
      var response = tokenRes.data['msg'];
      if (response == 'true') {
        //Dio dio = Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers['x-auth-token'] = token;
        Response userRes = await dio.get(
          '${Constants.uri}/authuser/user',
        );
        userProvider.setUser(userRes.toString());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signOutuser(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RegisterScreen()),
        (route) => false);
  }
}
