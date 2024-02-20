// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../exports.dart';

class PetDetails extends StatefulWidget {
  final Pet pet;
  final String userID;
  const PetDetails({super.key, required this.pet, required this.userID});

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  late List<UserDetails> users = [];
  bool _isLoading = true;
  int? likes;
  bool _isLiking = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future doLike() async {
    String uid = widget.userID;
    String pid = widget.pet.pid;
    try {
      setState(() {
        _isLiking = true;
      });
      final data = {'userId': uid, 'petId': pid};
      Response response =
          await Dio().post("${Constants.uri}/favourites/add", data: data);
      if (response.statusCode == 200) {
        setState(() {
          widget.pet.stars = widget.pet.stars + 1;
          _isLiked = true;
          _isLiking = false;
        });
      }
    } on DioError catch (e) {
      switch (e.response!.statusCode) {
        case 400:
          setState(() {
            // widget.pet.stars = widget.pet.stars + 1;
            _isLiked = true;
            _isLiking = false;
          });
          break;
        case 500:
          setState(() {
            // widget.pet.stars = widget.pet.stars + 1;
            _isLiked = true;
            _isLiking = false;
          });
          break;
        default:
          setState(() {
            //widget.pet.stars = widget.pet.stars + 1;
            _isLiked = true;

            _isLiking = false;
          });
          break;
      }
    }
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

  @override
  Widget build(BuildContext context) {
    // likes = widget.pet.stars;
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
                                        GestureDetector(
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                          onTap: () => doLike(),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(4, 0, 0, 0),
                                          child: _isLiking
                                              ? CircularProgressIndicator(
                                                  color: red,
                                                )
                                              : Text(
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
                                                      "Age:",
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
                                                      "${widget.pet.age} yrs",
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
                                                        color: Colors.black,
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
                                                  "Weight:",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "${widget.pet.weight} kg",
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
                                                      "Color:",
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
                                                        color: Colors.black,
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
                                                        color: Colors.black,
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
                                                  "Health:",
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
                                              "LIsted By::",
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
                                                  Image(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            users[0].urlImage),
                                                    height: 80,
                                                    width: 60,
                                                    fit: BoxFit.cover,
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
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 4, 0, 0),
                                                            child: Text(
                                                              "Reserve now to Get Contact Details",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
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
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsets.fromLTRB(
                                                  //           8, 0, 0, 0),
                                                  //   child: Column(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment
                                                  //             .start,
                                                  //     crossAxisAlignment:
                                                  //         CrossAxisAlignment
                                                  //             .start,
                                                  //     mainAxisSize:
                                                  //         MainAxisSize.max,
                                                  //     children: [
                                                  //       IconButton(
                                                  //         onPressed: () {},
                                                  //         icon: Icon(
                                                  //           Icons.favorite,
                                                  //           color: Color(
                                                  //               0xffff0004),
                                                  //           size: 16,
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.all(16),
                                        padding: EdgeInsets.all(8),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0x003a57e8),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        child: (widget.pet.uid == widget.userID)
                                            ? MaterialButton(
                                                onPressed: null,
                                                color: Color(0xff245cb5),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      width: 1),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                textColor: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                height: 50,
                                                minWidth: 140,
                                                child: Text(
                                                  "This is your Pet.",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              )
                                            : MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BookingScreen(
                                                                  pet: widget
                                                                      .pet)));
                                                },
                                                color: Color(0xff245cb5),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Color(0xff808080),
                                                      width: 1),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                textColor: Color(0xffffffff),
                                                height: 50,
                                                minWidth: 140,
                                                child: Text(
                                                  "AdoptNow",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
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
