// // ignore_for_file: prefer_const_constructors, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import "../../exports.dart";

// class BookingScreen extends StatefulWidget {
//   final Pet pet;
//   const BookingScreen({super.key, required this.pet});

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   TextEditingController _dateController = TextEditingController();

//   TextEditingController _timeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           alignment: Alignment.topLeft,
//           children: [
//             Image(
//               image: NetworkImage(widget.pet.imageUrl),
//               height: MediaQuery.of(context).size.height * 0.5,
//               width: MediaQuery.of(context).size.width,
//               fit: BoxFit.cover,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: EdgeInsets.all(0),
//                 padding: EdgeInsets.all(0),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.65,
//                 decoration: BoxDecoration(
//                   color: Color(0xffffffff),
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(16.0),
//                       topRight: Radius.circular(16.0)),
//                   border: Border.all(color: Color(0x4d9e9e9e), width: 1),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text(
//                           widget.pet.nickname,
//                           textAlign: TextAlign.start,
//                           overflow: TextOverflow.clip,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontStyle: FontStyle.normal,
//                             fontSize: 20,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                           child: Text(
//                             "Book Now To Reserve Me",
//                             textAlign: TextAlign.start,
//                             overflow: TextOverflow.clip,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 14,
//                               color: Color(0xff5e5e5e),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                           child: TextFormField(
//                             controller: _dateController,
//                             obscureText: false,
//                             textAlign: TextAlign.start,
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 14,
//                               color: Color(0xff000000),
//                             ),
//                             decoration: InputDecoration(
//                               disabledBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 borderSide: BorderSide(
//                                     color: Color(0xff000000), width: 1),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 borderSide: BorderSide(
//                                     color: Color(0xff000000), width: 1),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 borderSide: BorderSide(
//                                     color: Color(0xff000000), width: 1),
//                               ),
//                               hintText: "Select a Date",
//                               hintStyle: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 16,
//                                 color: Color.fromARGB(255, 244, 0, 0),
//                               ),
//                               labelText: "Date",
//                               labelStyle: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 16,
//                                 color: Color(0xff000000),
//                               ),
//                               filled: true,
//                               fillColor: Color(0x00ffffff),
//                               isDense: false,
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 12),
//                               prefixIcon: Icon(Icons.mail,
//                                   color: Color(0xff212435), size: 18),
//                             ),
//                             onTap: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(2023),
//                                   lastDate: DateTime(2024));

//                               if (pickedDate != null) {
//                                 String formattedDate =
//                                     DateFormat('yyyy-MM-dd').format(pickedDate);

//                                 setState(() {
//                                   _dateController.text =
//                                       formattedDate; //set output date to TextField value.
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                           child: TextFormField(
//                             controller: _timeController,
//                             obscureText: false,
//                             textAlign: TextAlign.start,
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 14,
//                               color: Color(0xff000000),
//                             ),
//                             decoration: InputDecoration(
//                               disabledBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 borderSide: BorderSide(
//                                     color: Color(0xff000000), width: 1),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 borderSide: BorderSide(
//                                     color: Color(0xff000000), width: 1),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 borderSide: BorderSide(
//                                     color: Color(0xff000000), width: 1),
//                               ),
//                               labelText: "Time",
//                               labelStyle: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 16,
//                                 color: Color(0xff000000),
//                               ),
//                               hintText: "Please Select Time",
//                               hintStyle: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Color(0xff000000),
//                               ),
//                               filled: true,
//                               fillColor: Color(0xffffffff),
//                               isDense: false,
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 12),
//                               prefixIcon: Icon(Icons.access_time,
//                                   color: Color(0xff212435), size: 18),
//                             ),
//                             onTap: () async {
//                               TimeOfDay? pickedTime = await showTimePicker(
//                                 initialTime: TimeOfDay.now(),
//                                 context: context,
//                               );

//                               if (pickedTime != null) {
//                                 DateTime parsedTime = DateFormat.jm().parse(
//                                     pickedTime.format(context).toString());

//                                 String formattedTime =
//                                     DateFormat('HH:mm').format(parsedTime);

//                                 setState(() {
//                                   _timeController.text = formattedTime;
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                           child: MaterialButton(
//                             onPressed: () {
//                               print(_dateController.text);
//                               print(_timeController.text);
//                             },
//                             color: Color(0xff3a57e8),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             padding: EdgeInsets.all(16),
//                             textColor: Color(0xffffffff),
//                             height: 45,
//                             minWidth: MediaQuery.of(context).size.width,
//                             child: Text(
//                               "Reserve Now",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
