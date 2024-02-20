// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../exports.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  late List<Booking> bookings = [];
  bool _isLoading = true;
  bool _isEmpty = true;

  String? userID;
  String? urlImageUser;
  String? nameUser;
  String? emailUser;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('_uid');
    urlImageUser = prefs.getString('imageUser');
    nameUser = prefs.getString('name');
    emailUser = prefs.getString('uEmail');
    setState(() => bookings.clear());
    setState(() {
      _isLoading = true;
    });
    try {
      Response response =
          await Dio().get("${Constants.uri}/book/myBookings/$userID");
      // bookings = List<Booking>.from(
      //   response.data.map((json) => Booking.fromJson(json)),
      // );
      setState(() {
        bookings = (response.data as List)
            .map((booking) => Booking.fromJson(booking))
            .toList();
        if (bookings.isEmpty) {
          _isEmpty = true;
          //_showMaterialDialog("Empty", "No data to show");
        } else {
          _isEmpty = false;
        }
        _isLoading = false;
        // print(pets);
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
                          setState(() {
                            _isEmpty = true;
                          });
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => HomePage()));
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
                          setState(() {
                            _isEmpty = true;
                          });
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => HomePage()));
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
                          setState(() {
                            _isEmpty = true;
                          });
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => HomePage()));
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

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(
        urlImg: urlImageUser,
        scaffoldKey: scaffoldKey,
        title: "My Bookings",
        context: context,
      ),
      drawer:
          DrawerWidget(email: emailUser, name: nameUser, image: urlImageUser),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.91,
        width: MediaQuery.of(context).size.height * 0.9,
        child: RefreshIndicator(
          onRefresh: refresh,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _isEmpty
                  ? Center(
                      child: DataNotFound(),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        //final pet = pets[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetBookingDetails(
                                  pet: bookings[index].pet,
                                  userID: userID as String,
                                  bid: bookings[index].id,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.height * 0.95,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.05),
                              ),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Center(
                                  child: SizedBox(
                                    height: constraints.maxHeight * 0.85,
                                    width: constraints.maxWidth * 0.93,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CardPerfil(
                                          height: constraints.maxWidth * 0.33,
                                          width: constraints.maxWidth * 0.33,
                                          color: Colors.blue.shade200,
                                          link: bookings[index].pet.imageUrl,
                                        ),
                                        CardTexts(
                                          widthA: constraints.maxWidth * 0.4,
                                          name: bookings[index].pet.nickname,
                                          race: bookings[index].pet.breed,
                                          old: bookings[index].pet.age,
                                          sex: bookings[index].pet.gender,
                                          distance:
                                              bookings[index].pet.location,
                                        ),
                                        CardIcon(
                                          stars: bookings[index].pet.stars,
                                          width: constraints.maxWidth * 0.13,
                                          height: constraints.maxHeight * 0.4,
                                          sizeIcon:
                                              constraints.maxHeight * 0.24,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      }),
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
