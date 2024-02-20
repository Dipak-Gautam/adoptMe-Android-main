//ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, file_names, prefer_final_fields
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "../../exports.dart";

class BookingScreen extends StatefulWidget {
  final Pet pet;
  const BookingScreen({super.key, required this.pet});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool _isSyncing = false;
  TextEditingController _dateController = TextEditingController();

  TextEditingController _timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: _isSyncing
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(widget.pet.imageUrl),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
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
                              Text(
                                widget.pet.nickname,
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
                                  "Reserve Me Now to Get Information",
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
                                  controller: _dateController,
                                  obscureText: false,
                                  validator: (value) => value!.isEmpty
                                      ? 'Date cannot be blank'
                                      : null,
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
                                    hintText: "Select a Date",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 244, 0, 0),
                                    ),
                                    labelText: "Date",
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
                                    prefixIcon: Icon(Icons.mail,
                                        color: Color(0xff212435), size: 18),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024));

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);

                                      setState(() {
                                        _dateController.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    }
                                  },
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: TextFormField(
                                        validator: (value) => value!.isEmpty
                                            ? 'Time cannot be blank'
                                            : null,
                                        controller: _timeController,
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
                                          labelText: "Time",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                            color: Color(0xff000000),
                                          ),
                                          hintText: "Please Select Time",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xffffffff),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          prefixIcon: Icon(Icons.access_time,
                                              color: Color(0xff212435),
                                              size: 18),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode:
                                                TimePickerEntryMode.input,
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());

                                            String formattedTime =
                                                DateFormat('HH:mm')
                                                    .format(parsedTime);

                                            setState(() {
                                              _timeController.text =
                                                  formattedTime;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            setState(() {
                                              _isSyncing = true;
                                            });
                                            final BookService bs =
                                                BookService();
                                            bs.bookPet(
                                                context: context,
                                                petID: widget.pet.pid,
                                                date: _dateController.text,
                                                time: _timeController.text);
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
                                          "Reserve Now",
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
