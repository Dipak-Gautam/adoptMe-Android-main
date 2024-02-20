// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

class PetBookingDetails extends StatefulWidget {
  final Pet pet;
  final String userID;
  final String bid;
  const PetBookingDetails(
      {super.key, required this.pet, required this.userID, required this.bid});

  @override
  State<PetBookingDetails> createState() => _PetBookingDetailsState();
}

class _PetBookingDetailsState extends State<PetBookingDetails> {
  late List<UserDetails> users = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future getUserDetails() async {
    String uid = widget.pet.uid;
    try {
      final data = {'uid': uid};
      Response response =
          await Dio().post("${Constants.uri}/user/details", data: data);
      setState(() {
        users = (response.data as List)
            .map((u) => UserDetails.fromJson(u))
            .toList();
        _isLoading = false;
      });
    } on Exception catch (e) {
      _showMaterialDialog("Error", e.toString());
    }
  }

  Future deleteBooking() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final data = {'bookingId': widget.bid};

      Response response =
          await Dio().post("${Constants.uri}/delete/removeBooking", data: data);
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Removed Booking"),
                  content: Text(response.data["message"]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
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
      setState(() {
        _isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    ImageScreen(imageUrl: widget.pet.imageUrl),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return child;
                                },
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'imageTag',
                            child: Image(
                              image: CachedNetworkImageProvider(
                                  widget.pet.imageUrl),
                              height: 450,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                  color: Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            widget.pet.nickname,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 32,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 22,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(4, 0, 0, 0),
                                          child: Text(
                                            (widget.pet.stars).toString(),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                      child: Text(
                                        "${widget.pet.gender}, ${widget.pet.category}, ${widget.pet.breed}",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                      child: Container(
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 8.0),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 25,
                                            ),
                                            Text(
                                              widget.pet.location,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 26,
                                                color: Color(0xff3a57e8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 20, 5, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 100,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Age",
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255, 1, 5, 0),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${widget.pet.age}yrs",
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff23751a),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 70,
                                            width: 100,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Weight",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                Text(
                                                  "${widget.pet.weight}kgs",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 20, 5, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 100,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Color",
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255, 1, 5, 0),
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.pet.color,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff23751a),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 70,
                                            width: 100,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Health",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                Text(
                                                  widget.pet.health,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    (widget.pet.uid == widget.userID)
                                        ? SizedBox(
                                            height: 5,
                                          )
                                        : Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 16, 0, 0),
                                            child: Text(
                                              "Listed By::",
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 26,
                                                color: Color(0xff3a57e8),
                                              ),
                                            ),
                                          ),
                                    (widget.pet.uid == widget.userID)
                                        ? SizedBox(
                                            height: 5,
                                          )
                                        : ListView(
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 16, 0, 0),
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                                  animation,
                                                                  secondaryAnimation) =>
                                                              ImageScreen(
                                                                  imageUrl: users[
                                                                          0]
                                                                      .urlImage),
                                                          transitionsBuilder:
                                                              (context,
                                                                  animation,
                                                                  secondaryAnimation,
                                                                  child) {
                                                            return child;
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      child: Hero(
                                                        tag: 'imageTag',
                                                        child: Image(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                                  users[0]
                                                                      .urlImage),
                                                          height: 60,
                                                          width: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            users[0].name,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 24,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 4, 0, 0),
                                                            child: Text(
                                                              users[0].address,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 22,
                                                                color: Color(
                                                                    0xff000000),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 4, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Phone 1: ${users[0].mobile}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 22,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Phone 2: ${users[0].phone}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 22,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 4, 5, 0),
                                                        child: Text(
                                                          "E-Mail:${users[0].email}",
                                                          textAlign:
                                                              TextAlign.justify,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  margin: EdgeInsets.all(16),
                                                  padding: EdgeInsets.all(8),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x003a57e8),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            Widget
                                                                cancelButton =
                                                                TextButton(
                                                              child: Text(
                                                                  "Cancel"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // dismiss dialog
                                                              },
                                                            );
                                                            Widget okButton =
                                                                TextButton(
                                                                    child: Text(
                                                                        "Remove"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      deleteBooking();
                                                                    });
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Confirm Action"),
                                                              content: Text(
                                                                  "Do you wish to remove the Booking? It is an non returnable action once commenced."),
                                                              actions: [
                                                                cancelButton,
                                                                okButton,
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    color: Color(0xff245cb5),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                          color:
                                                              Color(0xff808080),
                                                          width: 1),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                    textColor:
                                                        Color(0xffffffff),
                                                    height: 50,
                                                    minWidth: 140,
                                                    child: Text(
                                                      "Remove Booking",
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: Container(
                          //     margin: EdgeInsets.all(16),
                          //     padding: EdgeInsets.all(8),
                          //     width: MediaQuery.of(context).size.width,
                          //     height: 60,
                          //     decoration: BoxDecoration(
                          //       color: Color(0x003a57e8),
                          //       shape: BoxShape.rectangle,
                          //       borderRadius: BorderRadius.zero,
                          //     ),
                          //     child: MaterialButton(
                          //       onPressed: () {
                          //         print((widget.pet).toString());
                          //         print(widget.userID);
                          //       },
                          //       color: Color(0xff245cb5),
                          //       elevation: 0,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.zero,
                          //         side: BorderSide(color: Color(0xff808080), width: 1),
                          //       ),
                          //       padding:
                          //           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          //       textColor: Color(0xffffffff),
                          //       height: 50,
                          //       minWidth: 140,
                          //       child: Text(
                          //         "AdoptNow",
                          //         style: TextStyle(
                          //           fontSize: 22,
                          //           fontWeight: FontWeight.w400,
                          //           fontStyle: FontStyle.normal,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
