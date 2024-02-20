// ignore_for_file:   prefer_const_constructors, library_private_types_in_public_api, avoid_print, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:flutter/services.dart';

import 'dart:async';
// import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class EnterPetDetails extends StatefulWidget {
  const EnterPetDetails({super.key});

  @override
  State<EnterPetDetails> createState() => _EnterPetDetailsState();
}

class _EnterPetDetailsState extends State<EnterPetDetails> {
  final _formKey = GlobalKey<FormState>();
  var _image;
  String pic = "";
  int? check;
  String? gend = "Select Gender";
  String? cate = "Select Category";
  String? heal = "Select Health Condition";
  late String imgPath;
  bool _isSyncing = false;
  // Dio diod = Dio();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _breedController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _healthController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _nicknameController.dispose();
  //   _breedController.dispose();
  //   _categoryController.dispose();
  //   _ageController.dispose();
  //   _weightController.dispose();
  //   _healthController.dispose();
  //   _colorController.dispose();
  //   _locationController.dispose();
  //   _genderController.dispose();
  // }

  final AddService addService = AddService();
  void addPets() {
    setState(() {
      _isSyncing = true;
    });
    addService.addPets(
      context: context,
      nickname: _nicknameController.text,
      category: _categoryController.text,
      breed: _breedController.text,
      age: _ageController.text,
      weight: _weightController.text,
      health: _healthController.text,
      color: _colorController.text,
      location: _locationController.text,
      gender: _genderController.text,
      image: pic,
    );
  }

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    _image = photo!.path;
    pic = photo.path;
  }

  Future<void> _takePictureCamera() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    _image = photo!.path;
    pic = photo.path;
  }

  // Future<dynamic> _showDialog(
  //     {required BuildContext context,
  //     required String? response,
  //     required String title,
  //     required String routes}) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(response!.toString()),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               setState(() {
  //                 _isSyncing = false;
  //               });
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => PetListScreen()));
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text("Add Pets"),
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
      ),
      body: _isSyncing
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Nickname cannot be blank' : null,
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z ]')),
                        ],
                        controller: _nicknameController,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          labelText: "Nickname",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff6f6d6d),
                          ),
                          hintText: "Enter name",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          filled: true,
                          fillColor: Color(0x00ffffff),
                          isDense: false,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          prefixIcon: Icon(Icons.pets,
                              color: Color(0xff212435), size: 24),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: DropdownButton(
                            icon: Icon(Icons.male),
                            value: gend,
                            items: ["Select Gender", "Male", "Female"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            onChanged: (value) {
                              if (value == "Select Gender") {
                                showSnackBar(context, "Select a Valid Value");
                              }
                              setState(() {
                                gend = value;
                              });
                              _genderController.text = value as String;
                            },
                            elevation: 8,
                            isExpanded: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: DropdownButton(
                            icon: Icon(Icons.category),
                            value: cate,
                            items: [
                              "Dog",
                              "Cat",
                              "Bird",
                              "Others",
                              "Select Category"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            onChanged: (value) {
                              if (value == "Select Category") {
                                showSnackBar(context, "Select a Valid Value");
                              }
                              setState(() {
                                cate = value;
                              });
                              _categoryController.text = value as String;
                            },
                            elevation: 8,
                            isExpanded: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Breed cannot be blank' : null,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          controller: _breedController,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            labelText: "Breed",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff6f6d6d),
                            ),
                            hintText: "Enter breed",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0x00ffffff),
                            isDense: false,
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            prefixIcon: Icon(Icons.workspaces_outline,
                                color: Color(0xff212435), size: 24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: DropdownButton(
                            value: heal,
                            items: [
                              "Select Health Condition",
                              "Excellent",
                              "Good",
                              "Need Care"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            onChanged: (value) {
                              if (value == "Select Health Condition") {
                                showSnackBar(context, "Select a Valid Value");
                              }
                              setState(() {
                                heal = value;
                              });
                              _healthController.text = value as String;
                            },
                            elevation: 8,
                            isExpanded: true,
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Age cannot be blank' : null,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        controller: _ageController,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          labelText: "Age (in Years)",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff6f6d6d),
                          ),
                          hintText: "Enter age in years",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          filled: true,
                          fillColor: Color(0x00ffffff),
                          isDense: false,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          prefixIcon: Icon(Icons.favorite,
                              color: Color(0xff212435), size: 24),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Weight cannot be blank' : null,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          controller: _weightController,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            labelText: "Weight (in Kgs)",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff6f6d6d),
                            ),
                            hintText: "Enter weight",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0x00ffffff),
                            isDense: false,
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            prefixIcon: Icon(Icons.calendar_today,
                                color: Color(0xff212435), size: 24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Color cannot be blank' : null,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          controller: _colorController,
                          obscureText: false,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            labelText: "Color",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff6f6d6d),
                            ),
                            hintText: "Enter Color",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0x00ffffff),
                            isDense: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            prefixIcon: Icon(Icons.workspaces_filled, size: 24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextFormField(
                          validator: (value) => value!.isEmpty
                              ? 'Location cannot be blank'
                              : null,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z0-9 ]')),
                          ],
                          controller: _locationController,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            labelText: "Location",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff6f6d6d),
                            ),
                            hintText: "Enter Location",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0x00ffffff),
                            isDense: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            prefixIcon: Icon(Icons.location_on,
                                color: Color(0xff212435), size: 24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Text(
                          "Select a Picture(any one source)",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff0436d5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            MaterialButton(
                              onPressed: _takePicture,
                              color: Color(0xff0040f7),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.all(16),
                              textColor: Color(0xffffffff),
                              height: 40,
                              minWidth: 140,
                              child: Text(
                                "From Gallery",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: MaterialButton(
                                onPressed: _takePictureCamera,
                                color: Color(0xff0040f7),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Color(0xff808080), width: 1),
                                ),
                                padding: EdgeInsets.all(16),
                                textColor: Color(0xffffffff),
                                height: 40,
                                minWidth: 140,
                                child: Text(
                                  "From Camera",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: MaterialButton(
                          onPressed: () async {
                            // setState(() {
                            //   _isSyncing = true;
                            // });

                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // var userID = prefs.getString('_uid');
                            //print(userID);
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                _isSyncing = true;
                              });
                              //addPets();
                              final AddService addService = AddService();
                              // void addPets() {

                              addService.addPets(
                                context: context,
                                nickname: _nicknameController.text,
                                category: _categoryController.text,
                                breed: _breedController.text,
                                age: _ageController.text,
                                weight: _weightController.text,
                                health: _healthController.text,
                                color: _colorController.text,
                                location: _locationController.text,
                                gender: _genderController.text,
                                image: pic,
                              );
                              // }
                              // Dio dio = Dio();
                              // dio.options.headers['Content-Type'] =
                              //     "multipart/form-data";
                              // FormData formData = FormData.fromMap(<String, dynamic>{
                              //   // "image": await MultipartFile.fromFile(_image?.path,
                              //   //     filename: _image.path.split('/').last ?? 'image.jpeg'),
                              //   "image": await MultipartFile.fromFile(pic),
                              //   "nickname": _nicknameController.text,
                              //   "breed": _breedController.text,
                              //   "category": _categoryController.text,
                              //   "age": _ageController.text,
                              //   "weight": _weightController.text,
                              //   "health": _healthController.text,
                              //   "color": _colorController.text,
                              //   "location": _locationController.text,
                              //   //"uid": "5f3d4b3c5d8e4f3d4b3c5d8e",
                              //   "uid": userID,
                              // });

                              // try {
                              //   print(pic);

                              //   Response responseP = await dio.post(
                              //       "${Constants.uri}/add/addP",
                              //       data: formData);
                              //   if (responseP.statusCode == 201) {
                              //     // success
                              //     print(pic);
                              //     // check = responseR.statusCode;
                              //     print("success");

                              //     _showDialog(
                              //       context: this.context,
                              //       response: responseP.data['msg'],
                              //       title: 'Success',
                              //       routes: '/view',
                              //     );
                              //   } else {
                              //     // handle error
                              //     print("failed");
                              //     print(responseP.toString());
                              //     _showDialog(
                              //       context: this.context,
                              //       response: responseP.data['msg'],
                              //       title: 'Error',
                              //       routes: '/add',
                              //     );
                              //   }
                              // } catch (e) {
                              //   // handle error
                              //   print(e.toString());
                              //   _showDialog(
                              //     context: this.context,
                              //     response: e.toString(),
                              //     title: 'Error',
                              //     routes: '/add',
                              //   );
                              // }

                            }
                          },
                          color: Color(0xff078ce7),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side:
                                BorderSide(color: Color(0xff2ec2ca), width: 1),
                          ),
                          padding: EdgeInsets.all(16),
                          textColor: Color(0xffffffff),
                          height: 40,
                          minWidth: 140,
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
