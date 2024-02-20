// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../exports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isSyncing = false;
  final AuthService authService = AuthService();
  void loginUser() {
    authService.signInUser(
      context: context,
      username: _userNameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: _isSyncing
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  ///***If you have exported images you must have to copy those images in assets/images directory.
                  Image(
                    image: AssetImage('assets/auth/adpotLogin.png'),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0)),
                        border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Text(
                                      "Welcome",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(
                                        "Sign in to continue",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff5e5e5e),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        validator: (value) => value!.isEmpty
                                            ? 'Username cannot be blank'
                                            : value.length < 6
                                                ? 'Length is 6 character'
                                                : null,
                                        controller: _userNameController,
                                        obscureText: false,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          labelText: "Username",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                          ),
                                          filled: true,
                                          fillColor: Color(0x00ffffff),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          prefixIcon:
                                              Icon(Icons.person, size: 18),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        validator: (value) => value!.isEmpty
                                            ? 'password cannot be blank'
                                            : value.length < 8
                                                ? 'Length is 8 character'
                                                : null,
                                        controller: _passwordController,
                                        obscureText: !_passwordVisible,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xffffffff),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          prefixIcon: Icon(Icons.password),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                      child: MaterialButton(
                                        onPressed: () {
                                          final FormState? form =
                                              _formKey.currentState;

                                          if (form!.validate()) {
                                            setState(() {
                                              _isSyncing = true;
                                            });
                                            loginUser();
                                          }
                                        },
                                        color: Color(0xff3a57e8),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        textColor: Color(0xffffffff),
                                        height: 45,
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordInit())),
                                          child: Text(
                                            "Forgot Password?",
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14,
                                              color: Color(0xff5e5e5e),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => RegisterScreen(),
                                            ),
                                          );
                                        },
                                        color: Color(0xffffffff),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: BorderSide(
                                              color: Color(0xff808080),
                                              width: 1),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        textColor: Color(0xff000000),
                                        height: 45,
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
